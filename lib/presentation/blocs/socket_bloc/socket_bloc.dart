import 'dart:convert';
import 'dart:io';

import 'package:crypto_chart_view/presentation/blocs/socket_bloc/socket_event.dart';
import 'package:crypto_chart_view/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:crypto_chart_view/presentation/utils/resources/global_constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketBloc with BlocStreamMixin {
  SocketBloc([String address = socketSandboxBaseUrl]) : _address = address {
    _eventController.listen(_handleEvent);
    // _socketController.stream.listen(_handleSocketResponse);

    _socket = io(
      address,
      OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .setExtraHeaders(<String, dynamic>{
            "type": "hello",
            "apikey": "8F5DF575-B70E-458E-BBB9-A493CC66CD60",
            "heartbeat": false,
            "subscribe_data_type": ["trade"],
            "subscribe_filter_asset_id": ["BTC/USD"]
          })
          .build(),
    );
    _socket.connect();

    _socket.send([jsonEncode(<String, dynamic>{
      "type": "hello",
      "apikey": "8F5DF575-B70E-458E-BBB9-A493CC66CD60",
      "heartbeat": false,
      "subscribe_data_type": ["trade"],
      "subscribe_filter_asset_id": ["BTC/USD"]
    })]);
    // _socket.send([
    //   jsonEncode({
    //     "type": "hello",
    //     "apikey": "8F5DF575-B70E-458E-BBB9-A493CC66CD60",
    //     "heartbeat": false,
    //     "subscribe_data_type": ["trade"],
    //     "subscribe_filter_asset_id": ["BTC/USD"]
    //   })
    // ]);
    _socket.onConnecting((data) => _addEvent(const ConnectingSocketEvent()));
    _socket.onConnect((data) => _addEvent(const ConnectedSocketEvent()));
    _socket.onConnectError((data) => _addEvent(ConnectErrorSocketEvent(error: data)));
    _socket.onConnectTimeout((data) => _addEvent(ConnectTimeoutSocketEvent(timeout: data)));
    _socket.onDisconnect((data) => _addEvent(const DisconnectedSocketEvent()));
    _socket.onError((data) => _addEvent(ErrorSocketEvent(error: data)));
    _socket.on('joined', (data) => _addEvent(DataSocketEvent(data: data)));
  }

  late final Socket _socket;
  final String _address;

  final _eventController = BehaviorSubject<SocketEvent>();
  Function(SocketEvent) get _addEvent => sinkAdd(_eventController);

  // final _socketController = WebSocketChannel.connect(
  //   // Uri.parse('wss://ws.coinapi.io/v1/'),
  //   Uri.parse('wss://ws-sandbox.coinapi.io/v1/'),
  // );
  // SinkFunction<String> get _sendSocketData => _socketController.sink.add;

  final _socketResponseController = BehaviorSubject<Map<String, dynamic>?>();
  Stream<Map<String, dynamic>?> get socketResponseStream => _socketResponseController.stream;
  SinkFunction<Map<String, dynamic>?> get _setSocketResponse => sinkAdd(_socketResponseController);

  Future<void> _handleEvent(dynamic event) async {
    if (event is SocketEvent) {
      print(event);
      // if (event is InitialEvent) {
      //     {
      //   "type": "hello",
      //   "apikey": "8F5DF575-B70E-458E-BBB9-A493CC66CD60",
      //   "heartbeat": false,
      //   "subscribe_data_type": ["trade"],
      //   "subscribe_filter_asset_id": ["BTC/USD"]
      // }));
      if (event is ConnectingSocketEvent) {
        _socket.connect();
      } else if (event is ConnectedSocketEvent) {
        _socket.emit('msg', 'test');
      } else if (event is ConnectErrorSocketEvent) {
        print(event.error);
      } else if (event is ConnectTimeoutSocketEvent) {
        print(event.timeout);
      } else if (event is DisconnectedSocketEvent) {
      } else if (event is ErrorSocketEvent) {
        print(event.error);
      } else if (event is DataSocketEvent) {
        _setSocketResponse(event.data);
        print(event.data);
      }
    }
  }

  void _handleSocketResponse(dynamic socketResponse) {
    if (socketResponse is String) {
      // final Map<String, dynamic> responseMap = jsonDecode(socketResponse);
      // _setSocketResponse(socketResponse.split(','));
    }
  }

  @override
  void dispose() {
    _socket.close();
  }
}
