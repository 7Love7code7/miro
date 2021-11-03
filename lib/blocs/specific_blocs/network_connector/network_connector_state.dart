part of 'network_connector_cubit.dart';

abstract class NetworkConnectorState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NetworkConnectorInitialState extends NetworkConnectorState {}

class NetworkConnectorConnectingState extends NetworkConnectorState {}

class NetworkConnectorConnectedState extends NetworkConnectorState {
  final NetworkModel? currentNetwork;
  final DateTime connectTime;

  NetworkConnectorConnectedState({required this.currentNetwork}) : connectTime = DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NetworkConnectorConnectedState &&
          runtimeType == other.runtimeType &&
          connectTime == other.connectTime;

  @override
  int get hashCode => super.hashCode ^ connectTime.hashCode;
}

class NetworkConnectorErrorState extends NetworkConnectorState {}
