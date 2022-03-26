import 'package:crypto_chart_view/domain/entities/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';

class SetSocketRequest with IUseCase<NoParams, RequestWebSocketEntity> {
  const SetSocketRequest({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Future<NoParams> execute({required RequestWebSocketEntity params}) =>
      _remoteRepository.setSocketRequest(requestEntity: params);
}
