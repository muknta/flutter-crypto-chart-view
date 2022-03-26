import 'dart:async';
import 'dart:convert';

import 'package:crypto_chart_view/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketBlocClient with BlocStreamMixin {
  WebSocketBlocClient({required WebSocketChannel socketController}) : _socketController = socketController;

  final WebSocketChannel _socketController;

  Stream<Map<String, dynamic>> get socketResponseStream => _socketController.stream.transform(_streamTransformer);
  final _streamTransformer = StreamTransformer<dynamic, Map<String, dynamic>>.fromHandlers(
    handleData: (dynamic data, EventSink<Map<String, dynamic>> sink) {
      sink.add(jsonDecode(data as String));
    },
  );

  SinkFunction<String> get _setSocketRequest => _socketController.sink.add;

  Future<void> setSocketRequest({required Map<String, dynamic> parameters}) async =>
      _setSocketRequest(jsonEncode(parameters));

  @override
  void dispose() {
    _socketController.sink.close();
  }
}
