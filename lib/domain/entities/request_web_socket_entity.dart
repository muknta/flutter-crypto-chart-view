import 'package:crypto_chart_view/data/api/models/remote_models/request_web_socket_remote_model.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';

class RequestWebSocketEntity {
  const RequestWebSocketEntity({
    required this.fromCurrency,
    required this.toCurrency,
  });

  RequestWebSocketRemoteModel toRemoteModel() => RequestWebSocketRemoteModel(
        subscribeFilterAssetId: ['${fromCurrency.uppercasedName}/${toCurrency.uppercasedName}'],
      );

  final FromCurrencyEnum fromCurrency;
  final ToCurrencyEnum toCurrency;
}
