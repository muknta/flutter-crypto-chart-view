import 'package:crypto_chart_view/data/api/utils/settings/api_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_web_socket_remote_model.g.dart';

@JsonSerializable()
class RequestWebSocketRemoteModel {
  const RequestWebSocketRemoteModel({
    required this.subscribeFilterAssetId,
    this.type = 'hello',
    this.subscribeDataType = const ["trade"],
    this.heartbeat = false,
    this.apiKey = serviceApiKey,
  });

  Map<String, dynamic> toJson() => _$RequestWebSocketRemoteModelToJson(this);

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'apikey')
  final String apiKey;

  @JsonKey(name: 'heartbeat')
  final bool heartbeat;

  @JsonKey(name: 'subscribe_data_type')
  final List<String> subscribeDataType;

  @JsonKey(name: 'subscribe_filter_asset_id')
  final List<String> subscribeFilterAssetId;
}
