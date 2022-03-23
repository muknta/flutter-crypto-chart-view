import 'package:crypto_chart_view/data/api/rest_api/request/get_request_body.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';
import 'package:crypto_chart_view/domain/model/hour/hour.dart';

class FetchHourlyContent with IUseCase<List<Hour>, GetRequestBody> {
  const FetchHourlyContent({
    required IRemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final IRemoteRepository _remoteRepository;

  @override
  Future<List<Hour>> execute({required GetRequestBody params}) => _remoteRepository.fetchHourlyContent(
        language: params.language,
        longitude: params.longitude,
        latitude: params.latitude,
      );
}
