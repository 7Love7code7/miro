class Node {
  final String nodeType;
  final String seedNodeId;
  final String sentryNodeId;
  final String snapshotNodeId;
  final String validatorNodeId;

  Node({
    required this.nodeType,
    required this.seedNodeId,
    required this.sentryNodeId,
    required this.snapshotNodeId,
    required this.validatorNodeId,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        nodeType: json['node_type'] as String,
        seedNodeId: json['seed_node_id'] as String,
        sentryNodeId: json['sentry_node_id'] as String,
        snapshotNodeId: json['snapshot_node_id'] as String,
        validatorNodeId: json['validator_node_id'] as String,
      );
}
