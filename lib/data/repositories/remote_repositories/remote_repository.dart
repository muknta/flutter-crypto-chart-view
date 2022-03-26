import 'dart:async';

import 'package:crypto_chart_view/data/api/models/remote_models/response_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:crypto_chart_view/domain/entities/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/entities/response_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
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
}
