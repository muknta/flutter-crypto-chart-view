import 'dart:async';

import 'package:crypto_chart_view/data/api/models/remote_models/time_series/exchange_rate_time_series_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/web_socket/response_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:crypto_chart_view/domain/entities/time_series/exchange_rate_time_series_entity.dart';
import 'package:crypto_chart_view/domain/entities/web_socket/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/entities/web_socket/response_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IRemoteRepository)
class RemoteRepository implements IRemoteRepository {
  RemoteRepository({required IRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final IRemoteDataSource _remoteDataSource;

  @override
  Stream<ResponseWebSocketEntity> get socketResponseStream =>
      _remoteDataSource.socketResponseStream.transform(_streamTransformer);
  final _streamTransformer = StreamTransformer<ResponseWebSocketRemoteModel, ResponseWebSocketEntity>.fromHandlers(
    handleData: (ResponseWebSocketRemoteModel data, EventSink<ResponseWebSocketEntity> sink) {
      sink.add(ResponseWebSocketEntity.fromRemoteModel(data));
    },
  );

  @override
  Future<void> setSocketRequest({required RequestWebSocketEntity requestEntity}) =>
      _remoteDataSource.setSocketRequest(requestModel: requestEntity.toRemoteModel());

  @override
  Future<List<ExchangeRateTimeSeriesEntity>> getExchangeRatesTimeSeries({
    required ExchangeRateModel exchangeRate,
  }) async {
    final List<ExchangeRateTimeSeriesRemoteModel> remoteModelList =
        await _remoteDataSource.getExchangeRatesTimeSeries(exchangeRate: exchangeRate);
    return remoteModelList
        .map(
          (remoteModel) => ExchangeRateTimeSeriesEntity.fromRemoteModel(remoteModel: remoteModel),
        )
        .toList();
  }
}
