import 'dart:async';

import 'package:crypto_chart_view/data/api/utils/enums/period_id_request_time_series_enum.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/time_series/exchange_rate_time_series_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/web_socket/request_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/web_socket/response_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/api/rest_api/rest_client.dart';
import 'package:crypto_chart_view/data/api/utils/settings/api_config.dart';
import 'package:crypto_chart_view/data/api/utils/extensions/date_time_filter_extension.dart';
import 'package:crypto_chart_view/data/api/socket_api/web_socket_bloc_client.dart';
import 'package:crypto_chart_view/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@LazySingleton(as: IRemoteDataSource)
class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource() {
    _socketClient = WebSocketBlocClient(
      socketController: WebSocketChannel.connect(Uri.parse(webSocketSandboxBaseUrl)),
    );
    _restClient = RestClient(Dio(BaseOptions(
      headers: {"X-CoinAPI-Key": serviceApiKey},
    )));
  }

  late final WebSocketBlocClient _socketClient;
  late final RestClient _restClient;

  @override
  Stream<ResponseWebSocketRemoteModel> get socketResponseStream =>
      _socketClient.socketResponseStream.transform(_streamTransformer);

  final _streamTransformer = StreamTransformer<Map<String, dynamic>, ResponseWebSocketRemoteModel>.fromHandlers(
    handleData: (Map<String, dynamic> data, EventSink<ResponseWebSocketRemoteModel> sink) {
      sink.add(ResponseWebSocketRemoteModel.fromJson(data));
    },
  );

  @override
  Future<void> setSocketRequest({required RequestWebSocketRemoteModel requestModel}) =>
      _socketClient.setSocketRequest(parameters: requestModel.toJson());

  @override
  Future<List<ExchangeRateTimeSeriesRemoteModel>> getExchangeRatesTimeSeries({
    required ExchangeRateModel exchangeRate,
  }) {
    final currentDateTime = DateTime.now();
    final DateTime startDateTime = currentDateTime.subtract(const Duration(days: 15));

    return _restClient.getExchangeRatesTimeSeries(
      fromCurrency: exchangeRate.fromCurrency.uppercasedName,
      toCurrency: exchangeRate.toCurrency.uppercasedName,
      periodId: defaultPeriodId.apiName,
      timeStart: startDateTime.toFilteredIso6801String,
      timeEnd: currentDateTime.toFilteredIso6801String,
    );
  }
}
