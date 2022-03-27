import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

abstract class ILocalDataSource {
  const ILocalDataSource();

  Future<ExchangeRateModel?> getExchangeRateModel();

  Future<bool> setExchangeRateModel({required ExchangeRateModel exchangeModel});
}
