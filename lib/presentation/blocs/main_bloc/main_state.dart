import 'package:crypto_chart_view/domain/entities/response_web_socket_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

class LoadedActualDataState extends MainState {
  const LoadedActualDataState({
    required this.responseEntity,
  });

  final ResponseWebSocketEntity responseEntity;

  @override
  List<Object?> get props => [responseEntity];
}

class LoadedHistoricalDataState extends MainState {
  const LoadedHistoricalDataState();

  @override
  List<Object?> get props => [];
}
