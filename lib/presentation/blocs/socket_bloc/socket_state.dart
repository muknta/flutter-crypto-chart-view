import 'package:equatable/equatable.dart';

abstract class SocketState extends Equatable {
  const SocketState();

  @override
  List<Object?> get props => [];
}

class DataSocketState extends SocketState {
  const DataSocketState({required this.data});

  // TODO: set type
  final dynamic data;

  @override
  List<Object?> get props => [data];
}

class ConnectingSocketState extends SocketState {
  const ConnectingSocketState();
}

class ConnectedSocketState extends SocketState {
  const ConnectedSocketState();
}

class ConnectErrorSocketState extends SocketState {
  const ConnectErrorSocketState({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}

class ConnectTimeoutSocketState extends SocketState {
  const ConnectTimeoutSocketState({required this.timeout});

  // TODO: set type
  final dynamic timeout;

  @override
  List<Object?> get props => [timeout];
}

class DisconnectedSocketState extends SocketState {
  const DisconnectedSocketState();
}

class ErrorSocketState extends SocketState {
  const ErrorSocketState({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}
