import 'package:miro/infra/dto/api/withdraws/response/transactions.dart';

class WithdrawsResp {
  final List<Transactions> transactions;
  final int totalCount;

  WithdrawsResp({
    required this.transactions,
    required this.totalCount,
  });

  factory WithdrawsResp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> txs = json['transactions'] as Map<String, dynamic>;

    return WithdrawsResp(
      transactions: txs.keys
          .map<Transactions>((String key) => Transactions.fromJsonWithKey(txs[key] as Map<String, dynamic>, key))
          .toList(),
      totalCount: json['total_count'] as int,
    );
  }
}
