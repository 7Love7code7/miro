class SyncInfo {
  final String earliestAppHash;
  final String earliestBlockHash;
  final String earliestBlockHeight;
  final String earliestBlockTime;
  final String latestAppHash;
  final String latestBlockHash;
  final String latestBlockHeight;
  final String latestBlockTime;

  SyncInfo({
    required this.earliestAppHash,
    required this.earliestBlockHash,
    required this.earliestBlockHeight,
    required this.earliestBlockTime,
    required this.latestAppHash,
    required this.latestBlockHash,
    required this.latestBlockHeight,
    required this.latestBlockTime,
  });

  factory SyncInfo.fromJson(Map<String, dynamic> json) => SyncInfo(
        earliestAppHash: json['earliest_app_hash'] as String,
        earliestBlockHash: json['earliest_block_hash'] as String,
        earliestBlockHeight: json['earliest_block_height'] as String,
        earliestBlockTime: json['earliest_block_time'] as String,
        latestAppHash: json['latest_app_hash'] as String,
        latestBlockHash: json['latest_block_hash'] as String,
        latestBlockHeight: json['latest_block_height'] as String,
        latestBlockTime: json['latest_block_time'] as String,
      );
}
