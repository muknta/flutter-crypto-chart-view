import 'package:json_annotation/json_annotation.dart';

part 'response_web_socket_remote_model.g.dart';

@JsonSerializable()
class ResponseWebSocketRemoteModel {
  ResponseWebSocketRemoteModel({
    required this.timeExchange,
    required this.timeCoinapi,
    required this.uuid,
    required this.price,
    required this.size,
    required this.takerSide,
    required this.symbolId,
    required this.sequence,
    required this.type,
  });

  factory ResponseWebSocketRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseWebSocketRemoteModelFromJson(json);

  @JsonKey(name: 'time_exchange')
  final String timeExchange;

  @JsonKey(name: 'time_coinapi')
  final String timeCoinapi;

  @JsonKey(name: 'uuid')
  final String uuid;

  @JsonKey(name: 'price')
  final num price;

  @JsonKey(name: 'size')
  final num size;

  @JsonKey(name: 'taker_side')
  final String takerSide;

  @JsonKey(name: 'symbol_id')
  final String symbolId;

  @JsonKey(name: 'sequence')
  final int sequence;

  @JsonKey(name: 'type')
  final String type;
}
