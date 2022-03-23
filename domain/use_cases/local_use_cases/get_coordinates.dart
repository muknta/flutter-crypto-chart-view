import 'package:crypto_chart_view/domain/model/coords_model.dart';
import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';

class GetCoordinates with IUseCase<CoordsModel?, NoParams> {
  const GetCoordinates({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<CoordsModel?> execute({NoParams params}) async => _localRepository.getCoordinates();
}
