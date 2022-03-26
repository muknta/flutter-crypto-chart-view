import 'package:crypto_chart_view/domain/entities/response_web_socket_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

class ActualDataState extends MainState {
  const ActualDataState();
}

class LoadedActualDataState extends ActualDataState {
  const LoadedActualDataState({
    required this.responseEntity,
  });

  final ResponseWebSocketEntity responseEntity;

  @override
  List<Object?> get props => [responseEntity];
}

class FromCurrencySwitcherState extends ActualDataState {
  const FromCurrencySwitcherState({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [value];
}

class ToCurrencySwitcherState extends ActualDataState {
  const ToCurrencySwitcherState({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [value];
}

class LoadedHistoricalDataState extends MainState {
  const LoadedHistoricalDataState();

  @override
  List<Object?> get props => [];
}
