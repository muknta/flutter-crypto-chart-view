import 'package:crypto_chart_view/data/api/models/remote_models/time_series/exchange_rate_time_series_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/web_socket/request_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/web_socket/response_web_socket_remote_model.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

abstract class IRemoteDataSource {
  const IRemoteDataSource();

  Stream<ResponseWebSocketRemoteModel> get socketResponseStream;

  Future<void> setSocketRequest({required RequestWebSocketRemoteModel requestModel});

  Future<List<ExchangeRateTimeSeriesRemoteModel>> fetchExchangeRatesTimeSeries({
    required ExchangeRateModel exchangeRate,
  });
}
