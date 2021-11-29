import 'package:encrypt/encrypt.dart';
import 'package:miro/shared/utils/password_utils.dart';

class AesCoder {
  static String encrypt(String password, String content) {
    final Key key = Key.fromUtf8(PasswordUtils.fillToLength(text: password, length: 32));
    final Encrypter crypt = Encrypter(AES(key));
    String encryptedString = crypt.encrypt(content, iv: IV.fromLength(16)).base64;
    return encryptedString;
  }

  static String decrypt(String password, String content) {
    final Key key = Key.fromUtf8(PasswordUtils.fillToLength(text: password, length: 32));
    final Encrypter crypt = Encrypter(AES(key));
    String decryptedString = crypt.decrypt(Encrypted.fromBase64(content), iv: IV.fromLength(16));
    return decryptedString;
  }
}
