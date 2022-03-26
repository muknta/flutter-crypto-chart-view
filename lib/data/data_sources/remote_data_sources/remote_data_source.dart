import 'dart:async';

import 'package:crypto_chart_view/data/api/models/remote_models/request_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/response_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/api/settings/api_config.dart';
import 'package:crypto_chart_view/data/api/socket_api/web_socket_bloc_client.dart';
import 'package:crypto_chart_view/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@LazySingleton(as: IRemoteDataSource)
class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource() {
    _socketClient = WebSocketBlocClient(
      socketController: WebSocketChannel.connect(Uri.parse(webSocketSandboxBaseUrl)),
    );
  }

  late final WebSocketBlocClient _socketClient;

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
}
