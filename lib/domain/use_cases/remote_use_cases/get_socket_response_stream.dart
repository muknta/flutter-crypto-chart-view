import 'package:crypto_chart_view/domain/entities/response_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';

class GetSocketResponseStream with IUseCase<Stream<ResponseWebSocketEntity>, NoParams> {
  const GetSocketResponseStream({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Stream<ResponseWebSocketEntity> execute({NoParams params}) => _remoteRepository.socketResponseStream;
}
