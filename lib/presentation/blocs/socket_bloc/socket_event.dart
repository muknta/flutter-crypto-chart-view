import 'package:equatable/equatable.dart';

abstract class SocketEvent extends Equatable {
  const SocketEvent();

  @override
  List<Object?> get props => [];
}

class DataSocketEvent extends SocketEvent {
  const DataSocketEvent({required this.data});

  final Map<String, dynamic>? data;

  @override
  List<Object?> get props => [data];
}

class ConnectingSocketEvent extends SocketEvent {
  const ConnectingSocketEvent();
}

class ConnectedSocketEvent extends SocketEvent {
  const ConnectedSocketEvent();
}

class ConnectErrorSocketEvent extends SocketEvent {
  const ConnectErrorSocketEvent({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}

class ConnectTimeoutSocketEvent extends SocketEvent {
  const ConnectTimeoutSocketEvent({required this.timeout});

  // TODO: set type
  final dynamic timeout;

  @override
  List<Object?> get props => [timeout];
}

class DisconnectedSocketEvent extends SocketEvent {
  const DisconnectedSocketEvent();
}

class ErrorSocketEvent extends SocketEvent {
  const ErrorSocketEvent({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}
