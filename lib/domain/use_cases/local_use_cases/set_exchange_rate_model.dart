import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/use_cases/i_use_case.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';

class SetExchangeRateModel with IUseCase<Future<bool>, ExchangeRateModel> {
  const SetExchangeRateModel({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required ExchangeRateModel params}) =>
      _localRepository.setExchangeRateModel(exchangeModel: params);
}
