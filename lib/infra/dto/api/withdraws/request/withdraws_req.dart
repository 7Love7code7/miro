class WithdrawsReq {
  String account;
  String? last;
  int? page;
  int? pageSize;
  String? type;

  WithdrawsReq({
    required this.account,
    this.last,
    this.page,
    this.pageSize,
    this.type,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'account': account,
        'last': last,
        'page': page,
        'page_size': pageSize,
        'type': type,
      };
}
