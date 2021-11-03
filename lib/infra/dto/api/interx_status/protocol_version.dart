class ProtocolVersion {
  final String app;
  final String block;
  final String p2p;

  ProtocolVersion({
    required this.app,
    required this.block,
    required this.p2p,
  });

  factory ProtocolVersion.fromJson(Map<String, dynamic> json) => ProtocolVersion(
        app: json['app'] as String,
        block: json['block'] as String,
        p2p: json['p2p'] as String,
      );
}
