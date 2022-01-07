part of 'homedata_cubit.dart';

enum RequestStatus { initial, loading, success, failure }

extension RequestStatusX on RequestStatus {
  bool get isInitial => this == RequestStatus.initial;
  bool get isLoading => this == RequestStatus.loading;
  bool get isSuccess => this == RequestStatus.success;
  bool get isFailure => this == RequestStatus.failure;
}

class HomeDataState {
  HomeDataState({
    this.status = 'initial',
    Map<String, dynamic>? document,
  }) : document = document ?? {};

  final String status;
  final Map<String, dynamic>? document;

  HomeDataState copyWith({
    String? status,
    document,
  }) {
    return HomeDataState(
      status: status ?? this.status,
      document: document ?? this.document,
    );
  }
}
