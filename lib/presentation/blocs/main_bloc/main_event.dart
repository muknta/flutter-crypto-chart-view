import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends MainEvent {
  const InitialEvent();
}

class ActualDataRequestEvent extends MainEvent {
  const ActualDataRequestEvent({
    required this.fromCurrency,
    required this.toCurrency,
  });

  final FromCurrencyEnum fromCurrency;
  final ToCurrencyEnum toCurrency;

  @override
  List<Object?> get props => [fromCurrency, toCurrency];
}

class HistoricalDataRequestEvent extends MainEvent {
  const HistoricalDataRequestEvent();

  @override
  List<Object?> get props => [];
}
