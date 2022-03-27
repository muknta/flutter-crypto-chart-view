import 'package:crypto_chart_view/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {
  const LocalRepository({
    required ILocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final ILocalDataSource _localDataSource;

  @override
  Future<ExchangeRateModel?> getExchangeRateModel() => _localDataSource.getExchangeRateModel();

  @override
  Future<bool> setExchangeRateModel({required ExchangeRateModel exchangeModel}) =>
      _localDataSource.setExchangeRateModel(exchangeModel: exchangeModel);
}
