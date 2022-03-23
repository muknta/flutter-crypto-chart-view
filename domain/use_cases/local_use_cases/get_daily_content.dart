import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';
import 'package:crypto_chart_view/domain/model/day/day.dart';

class GetDailyContent with IUseCase<List<Day>, NoParams> {
  const GetDailyContent({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<List<Day>> execute({NoParams params}) => _localRepository.getDailyContent();
}
