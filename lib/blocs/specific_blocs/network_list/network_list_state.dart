part of 'network_list_cubit.dart';

abstract class NetworkListState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NetworkListInitialState extends NetworkListState {}

class NetworkListLoadingState extends NetworkListState {}

class NetworkListLoadedState extends NetworkListState {
  final List<NetworkModel> networkList;
  final DateTime lastUpdateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NetworkListLoadedState &&
          runtimeType == other.runtimeType &&
          lastUpdateTime == other.lastUpdateTime;

  @override
  int get hashCode => super.hashCode ^ lastUpdateTime.hashCode;

  NetworkListLoadedState({required this.networkList}) : lastUpdateTime = DateTime.now();
}

class NetworkListErrorState extends NetworkListState {}
