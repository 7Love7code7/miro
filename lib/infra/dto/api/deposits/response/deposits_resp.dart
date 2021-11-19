import 'package:miro/infra/dto/api/deposits/response/transactions.dart';

class DepositsResp {
  final List<Transactions> transactions;
  final int totalCount;

  DepositsResp({
    required this.transactions,
    required this.totalCount,
  });

  factory DepositsResp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> txs = json['transactions'] as Map<String, dynamic>;

    return DepositsResp(
      transactions: txs.keys
          .map<Transactions>((String key) => Transactions.fromJsonWithKey(txs[key] as Map<String, dynamic>, key))
          .toList(),
      totalCount: json['total_count'] as int,
    );
  }
}