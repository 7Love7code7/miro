import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:pointycastle/api.dart' show PrivateKeyParameter, PublicKeyParameter;
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart' show ECPrivateKey, ECPublicKey, ECSignature, ECPoint;
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

final Uint8List zero32 = Uint8List.fromList(List<int>.generate(32, (int index) => 0));
final List<int> ecGroupOrder = HEX.decode('fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141');
final List<int> ecP = HEX.decode('fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f');
final ECCurve_secp256k1 secp256k1 = ECCurve_secp256k1();
final BigInt n = secp256k1.n;
final BigInt negativeFlag = BigInt.from(0x80);
final ECPoint G = secp256k1.G;
BigInt nDiv2 = n >> 1;
const String throwBadPrivate = 'Expected Private';
const String throwBadPoint = 'Expected Point';
const String throwBadTweak = 'Expected Tweak';
const String throwBadHash = 'Expected Hash';
const String throwBadSignature = 'Expected Signature';

bool isPrivate(Uint8List x) {
  if (!isScalar(x)) return false;
  return _compare(x, zero32) > 0 && // > 0
      _compare(x, ecGroupOrder as Uint8List) < 0; // < G
}

bool isPoint(Uint8List p) {
  if (p.length < 33) {
    return false;
  }
  int t = p[0];
  Uint8List x = p.sublist(1, 33);

  if (_compare(x, zero32) == 0) {
    return false;
  }
  if (_compare(x, ecP as Uint8List) == 1) {
    return false;
  }
  try {
    decodeFrom(p);
  } on Exception {
    return false;
  }
  if ((t == 0x02 || t == 0x03) && p.length == 33) {
    return true;
  }
  Uint8List y = p.sublist(33);
  if (_compare(y, zero32) == 0) {
    return false;
  }
  if (_compare(y, ecP as Uint8List) == 1) {
    return false;
  }
  if (t == 0x04 && p.length == 65) {
    return true;
  }
  return false;
}

bool isScalar(Uint8List x) {
  return x.length == 32;
}

bool isOrderScalar(Uint8List x) {
  if (!isScalar(x)) return false;
  return _compare(x, ecGroupOrder as Uint8List) < 0; // < G
}

bool isSignature(Uint8List value) {
  Uint8List r = value.sublist(0, 32);
  Uint8List s = value.sublist(32, 64);

  return value.length == 64 && _compare(r, ecGroupOrder as Uint8List) < 0 && _compare(s, ecGroupOrder as Uint8List) < 0;
}

bool _isPointCompressed(Uint8List p) {
  return p[0] != 0x04;
}

bool assumeCompression({bool? compressed, Uint8List? pubKey}) {
  if (compressed == null && pubKey != null) return _isPointCompressed(pubKey);
  if (compressed == null) return true;
  return compressed;
}

Uint8List? pointFromScalar({required Uint8List scalar, required bool compressed}) {
  if (!isPrivate(scalar)) throw ArgumentError(throwBadPrivate);
  BigInt dd = fromBuffer(scalar);
  ECPoint pp = G * dd as ECPoint;
  if (pp.isInfinity) return null;
  return getEncoded(pp, compressed: compressed);
}

Uint8List? pointAddScalar(Uint8List pubKey, Uint8List tweak, {required bool compressed}) {
  if (!isPoint(pubKey)) throw ArgumentError(throwBadPoint);
  if (!isOrderScalar(tweak)) throw ArgumentError(throwBadTweak);
  bool isCompressed = assumeCompression(compressed: compressed, pubKey: pubKey);
  ECPoint? pp = decodeFrom(pubKey);
  if (_compare(tweak, zero32) == 0) return getEncoded(pp, compressed: compressed);
  BigInt tt = fromBuffer(tweak);
  ECPoint qq = G * tt as ECPoint;
  ECPoint uu = pp! + qq as ECPoint;
  if (uu.isInfinity) return null;
  return getEncoded(uu, compressed: isCompressed);
}

Uint8List? privateAdd(Uint8List d, Uint8List tweak) {
  if (!isPrivate(d)) throw ArgumentError(throwBadPrivate);
  if (!isOrderScalar(tweak)) throw ArgumentError(throwBadTweak);
  BigInt dd = fromBuffer(d);
  BigInt tt = fromBuffer(tweak);
  Uint8List dt = toBuffer((dd + tt) % n);

  if (dt.length < 32) {
    Uint8List padLeadingZero = Uint8List(32 - dt.length);
    dt = Uint8List.fromList(padLeadingZero + dt);
  }

  if (!isPrivate(dt)) return null;
  return dt;
}

Uint8List sign(Uint8List hash, Uint8List x) {
  if (!isScalar(hash)) throw ArgumentError(throwBadHash);
  if (!isPrivate(x)) throw ArgumentError(throwBadPrivate);
  ECSignature sig = deterministicGenerateK(hash, x);
  Uint8List buffer = Uint8List(64)..setRange(0, 32, _encodeBigInt(sig.r));
  late BigInt s;
  if (sig.s.compareTo(nDiv2) > 0) {
    s = n - sig.s;
  } else {
    s = sig.s;
  }
  buffer.setRange(32, 64, _encodeBigInt(s));
  return buffer;
}

bool verify(Uint8List hash, Uint8List q, Uint8List signature) {
  if (!isScalar(hash)) throw ArgumentError(throwBadHash);
  if (!isPoint(q)) throw ArgumentError(throwBadPoint);
  // 1.4.1 Enforce r and s are both integers in the interval [1, n − 1] (1, isSignature enforces '< n - 1')
  if (!isSignature(signature)) throw ArgumentError(throwBadSignature);

  ECPoint? Q = decodeFrom(q);
  BigInt r = fromBuffer(signature.sublist(0, 32));
  BigInt s = fromBuffer(signature.sublist(32, 64));

  final ECDSASigner signer = ECDSASigner(null, HMac(SHA256Digest(), 64))
    ..init(false, PublicKeyParameter<ECPublicKey>(ECPublicKey(Q, secp256k1)));
  return signer.verifySignature(hash, ECSignature(r, s));
  /* STEP BY STEP
  // 1.4.1 Enforce r and s are both integers in the interval [1, n − 1] (2, enforces '> 0')
  if (r.compareTo(n) >= 0) return false;
  if (s.compareTo(n) >= 0) return false;
  // 1.4.2 H = Hash(M), already done by the user
  // 1.4.3 e = H
  BigInt e = fromBuffer(hash);
  BigInt sInv = s.modInverse(n);
  BigInt u1 = (e * sInv) % n;
  BigInt u2 = (r * sInv) % n;
  // 1.4.5 Compute R = (xR, yR)
  //               R = u1G + u2Q
  ECPoint R = G * u1 + Q * u2;
  // 1.4.5 (cont.) Enforce R is not at infinity
  if (R.isInfinity) return false;
  // 1.4.6 Convert the field element R.x to an integer
  BigInt xR = R.x.toBigInteger();
  // 1.4.7 Set v = xR mod n
  BigInt v = xR % n;
  // 1.4.8 If v = r, output "valid", and if v != r, output "invalid"
  return v.compareTo(r) == 0;
  */
}

/// Decode a BigInt from bytes in big-endian encoding.
BigInt _decodeBigInt(List<int> bytes) {
  BigInt result = BigInt.from(0);
  for (int i = 0; i < bytes.length; i++) {
    result += BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
  }
  return result;
}

BigInt _byteMask = BigInt.from(0xff);

/// Encode a BigInt into bytes using big-endian encoding.
Uint8List _encodeBigInt(BigInt number) {
  int needsPaddingByte;
  int rawSize;

  if (number > BigInt.zero) {
    rawSize = (number.bitLength + 7) >> 3;
    needsPaddingByte = ((number >> (rawSize - 1) * 8) & negativeFlag) == negativeFlag ? 1 : 0;

    if (rawSize < 32) {
      needsPaddingByte = 1;
    }
  } else {
    needsPaddingByte = 0;
    rawSize = (number.bitLength + 8) >> 3;
  }

  final int size = rawSize < 32 ? rawSize + needsPaddingByte : rawSize;
  Uint8List result = Uint8List(size);
  for (int i = 0; i < size; i++) {
    result[size - i - 1] = (number & _byteMask).toInt();
    // ignore: parameter_assignments
    number = number >> 8;
  }
  return result;
}

BigInt fromBuffer(Uint8List d) {
  return _decodeBigInt(d);
}

Uint8List toBuffer(BigInt d) {
  return _encodeBigInt(d);
}

ECPoint? decodeFrom(Uint8List P) {
  return secp256k1.curve.decodePoint(P);
}

Uint8List getEncoded(ECPoint? P, {required bool compressed}) {
  return P!.getEncoded(compressed);
}

ECSignature deterministicGenerateK(Uint8List hash, Uint8List x) {
  final ECDSASigner signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
  PrivateKeyParameter<ECPrivateKey> pkp = PrivateKeyParameter<ECPrivateKey>(ECPrivateKey(_decodeBigInt(x), secp256k1));
  signer.init(true, pkp);
//  signer.init(false, new PublicKeyParameter(new ECPublicKey(secp256k1.curve.decodePoint(x), secp256k1)));
  return signer.generateSignature(hash) as ECSignature;
}

int _compare(Uint8List a, Uint8List b) {
  BigInt aa = fromBuffer(a);
  BigInt bb = fromBuffer(b);
  if (aa == bb) return 0;
  if (aa > bb) return 1;
  return -1;
}
