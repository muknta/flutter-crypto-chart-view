import 'package:crypto_chart_view/domain/entities/time_series/exchange_rate_time_series_entity.dart';
import 'package:crypto_chart_view/domain/entities/web_socket/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/entities/web_socket/response_web_socket_entity.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

abstract class IRemoteRepository {
  const IRemoteRepository();

  Stream<ResponseWebSocketEntity> get socketResponseStream;

  Future<void> setSocketRequest({required RequestWebSocketEntity requestEntity});

  Future<List<ExchangeRateTimeSeriesEntity>> fetchExchangeRatesTimeSeries({
    required ExchangeRateModel exchangeRate,
  });
}
