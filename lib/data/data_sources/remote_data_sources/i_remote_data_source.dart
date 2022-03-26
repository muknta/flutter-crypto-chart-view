import 'package:crypto_chart_view/data/api/models/remote_models/request_web_socket_remote_model.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/response_web_socket_remote_model.dart';

abstract class IRemoteDataSource {
  const IRemoteDataSource();

  Stream<ResponseWebSocketRemoteModel> get socketResponseStream;

  Future<void> setSocketRequest({required RequestWebSocketRemoteModel requestModel});
}
