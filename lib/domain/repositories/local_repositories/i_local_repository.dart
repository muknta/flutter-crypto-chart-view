import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

abstract class ILocalRepository {
  const ILocalRepository();

  Future<ExchangeRateModel?> getExchangeRateModel();

  Future<bool> setExchangeRateModel({required ExchangeRateModel exchangeModel});
}
