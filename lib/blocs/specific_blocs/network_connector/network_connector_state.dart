part of 'network_connector_cubit.dart';

abstract class NetworkConnectorState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NetworkConnectorInitialState extends NetworkConnectorState {}

class NetworkConnectorConnectingState extends NetworkConnectorState {}

class NetworkConnectorConnectedState extends NetworkConnectorState {
  final NetworkModel currentNetwork;

  NetworkConnectorConnectedState({required this.currentNetwork});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NetworkConnectorConnectedState &&
          runtimeType == other.runtimeType &&
          currentNetwork == other.currentNetwork;

  @override
  int get hashCode => super.hashCode ^ currentNetwork.hashCode;
}

class NetworkConnectorErrorState extends NetworkConnectorState {}
