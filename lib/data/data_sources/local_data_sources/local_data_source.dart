import 'package:crypto_chart_view/data/api/db_api/sembast_api/dao/currency_sembast_dao.dart';
import 'package:crypto_chart_view/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  const LocalDataSource({required CurrencySembastDao currencyDao}) : _currencyDao = currencyDao;

  final CurrencySembastDao _currencyDao;

  @override
  Future<ExchangeRateModel?> getExchangeRateModel() async {
    final String? fromCurrencyStr = await _currencyDao.getFromCurrency();
    if (fromCurrencyStr == null || fromCurrencyStr.isEmpty) {
      return null;
    }
    final String? toCurrencyStr = await _currencyDao.getToCurrency();
    // ---
    // Code repeats but it helps to DECREASE possible unneeded operations
    // ---
    if (toCurrencyStr == null || toCurrencyStr.isEmpty) {
      return null;
    }
    final FromCurrencyEnum? fromCurrency = fromCurrencyStr.fromCurrencyEnumValue;
    if (fromCurrency == null) {
      return null;
    }
    final ToCurrencyEnum? toCurrency = toCurrencyStr.toCurrencyEnumValue;
    if (toCurrency == null) {
      return null;
    }
    return ExchangeRateModel(fromCurrency: fromCurrency, toCurrency: toCurrency);
  }

  @override
  Future<bool> setExchangeRateModel({required ExchangeRateModel exchangeModel}) async {
    return _currencyDao
        .setToCurrency(exchangeModel.toCurrency.uppercasedName)
        .then((_) => _currencyDao.setFromCurrency(exchangeModel.fromCurrency.uppercasedName));
  }
}
