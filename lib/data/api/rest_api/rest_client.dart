import 'package:crypto_chart_view/data/api/models/remote_models/time_series/exchange_rate_time_series_remote_model.dart';
import 'package:crypto_chart_view/data/api/utils/settings/api_config.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: restApiProductionBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/v1/exchangerate/{asset_id_base}/{asset_id_quote}/history')
  Future<List<ExchangeRateTimeSeriesRemoteModel>> fetchExchangeRatesTimeSeries({
    @Path('asset_id_base') required String fromCurrency,
    @Path('asset_id_quote') required String toCurrency,
    @Query('period_id') required String periodId,
    @Query('time_start') required String timeStart,
    @Query('time_end') required String timeEnd,
  });
}
