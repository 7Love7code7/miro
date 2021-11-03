class PubKey {
  final String type;
  final String value;

  PubKey({
    required this.type,
    required this.value,
  });

  factory PubKey.fromJson(Map<String, dynamic> json) => PubKey(
        type: json['type'] as String,
        value: json['value'] as String,
      );
}
