import 'package:crypto_chart_view/domain/entities/time_series/exchange_rate_time_series_entity.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

class GetExchangeRatesTimeSeries with IUseCase<Future<List<ExchangeRateTimeSeriesEntity>>, ExchangeRateModel> {
  const GetExchangeRatesTimeSeries({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Future<List<ExchangeRateTimeSeriesEntity>> execute({required ExchangeRateModel params}) async =>
      _remoteRepository.getExchangeRatesTimeSeries(exchangeRate: params);
}
