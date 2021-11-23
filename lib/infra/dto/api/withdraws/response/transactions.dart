import 'package:miro/infra/dto/api/withdraws/response/tx.dart';

class Transactions {
  final String hash;
  final int time;
  final List<Tx>? txs;

  Transactions({
    required this.hash,
    required this.time,
    required this.txs,
  });

  factory Transactions.fromJsonWithKey(Map<String, dynamic> json, String key) {
    return Transactions(
      hash: key,
      time: json['time'] as int,
      txs: json['txs'] != null
          ? (json['txs'] as List<dynamic>).map((dynamic e) => Tx.fromJson(e as Map<String, dynamic>)).toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'Transactions{hash: $hash, time: $time, txs: $txs}';
  }
}
