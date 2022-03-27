import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:equatable/equatable.dart';

class ExchangeRateModel extends Equatable {
  const ExchangeRateModel({
    required this.fromCurrency,
    required this.toCurrency,
  });

  final FromCurrencyEnum fromCurrency;
  final ToCurrencyEnum toCurrency;

  @override
  List<Object?> get props => [fromCurrency, toCurrency];
}
