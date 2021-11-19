class BalanceReq {
  final String address;
  final Parameters? parameters;

  BalanceReq({
    required this.address,
    this.parameters,
  });
}

class Parameters {
  static bool countTotal = true;
  final int? limit;
  final int? offset;

  Parameters({
    this.limit,
    this.offset,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count_total': countTotal,
        'limit': limit,
        'offset': offset,
      };
}
