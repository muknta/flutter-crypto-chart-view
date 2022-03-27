import 'package:crypto_chart_view/data/api/models/remote_models/web_socket/request_web_socket_remote_model.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';

class RequestWebSocketEntity {
  const RequestWebSocketEntity({required this.exchangeRateModel});

  RequestWebSocketRemoteModel toRemoteModel() => RequestWebSocketRemoteModel(
        subscribeFilterAssetId: [
          '${exchangeRateModel.fromCurrency.uppercasedName}/${exchangeRateModel.toCurrency.uppercasedName}'
        ],
      );

  final ExchangeRateModel exchangeRateModel;
}
