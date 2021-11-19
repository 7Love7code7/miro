class Tx {
  final String address;
  final String type;
  final String denom;
  final int amount;

  Tx({
    required this.address,
    required this.type,
    required this.denom,
    required this.amount,
  });

  factory Tx.fromJson(Map<String, dynamic> json) => Tx(
        address: json['address'] as String,
        type: json['type'] as String,
        denom: json['denom'] as String,
        amount: json['amount'] as int,
      );
}
