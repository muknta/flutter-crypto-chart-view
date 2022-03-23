import 'package:crypto_chart_view/domain/model/coords_model.dart';
import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';

class SetCoordinates with IUseCase<bool, CoordsModel> {
  const SetCoordinates({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required CoordsModel params}) async => _localRepository.setCoordinates(coordsModel: params);
}
