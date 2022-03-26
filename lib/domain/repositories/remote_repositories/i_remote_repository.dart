import 'package:crypto_chart_view/domain/entities/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/entities/response_web_socket_entity.dart';

abstract class IRemoteRepository {
  const IRemoteRepository();

  Stream<ResponseWebSocketEntity> get socketResponseStream;

  Future<void> setSocketRequest({required RequestWebSocketEntity requestEntity});
}
