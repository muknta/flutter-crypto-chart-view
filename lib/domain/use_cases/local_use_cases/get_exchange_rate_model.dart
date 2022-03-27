import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

class GetExchangeRateModel with IUseCase<Future<ExchangeRateModel?>, NoParams> {
  const GetExchangeRateModel({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<ExchangeRateModel?> execute({NoParams params}) => _localRepository.getExchangeRateModel();
}
