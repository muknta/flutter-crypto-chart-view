import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';
import 'package:crypto_chart_view/domain/model/hour/hour.dart';

class GetHourlyContent with IUseCase<List<Hour>, NoParams> {
  const GetHourlyContent({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<List<Hour>> execute({NoParams params}) => _localRepository.getHourlyContent();
}
