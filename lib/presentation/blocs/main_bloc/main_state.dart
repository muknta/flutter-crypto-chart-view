import 'package:crypto_chart_view/domain/entities/web_socket/response_web_socket_entity.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_chart_view_model.dart';
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

class ExchangeRateChartViewState extends MainState {
  const ExchangeRateChartViewState({required this.chartViewModels});

  final List<ExchangeRateChartViewModel> chartViewModels;

  @override
  List<Object?> get props => [chartViewModels];
}
