import 'package:collection/collection.dart';
import 'package:crypto_chart_view/data/api/models/remote_models/response_web_socket_remote_model.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';

class ResponseWebSocketEntity {
  const ResponseWebSocketEntity({
    required this.fromCurrency,
    required this.toCurrency,
    required this.price,
    required this.time,
  });

  factory ResponseWebSocketEntity.fromRemoteModel(ResponseWebSocketRemoteModel remoteModel) {
    final List<String> symbolParts = remoteModel.symbolId.split('_');
    final int length = symbolParts.length;
    if (length >= 2) {
      final String fromCurrency = symbolParts.elementAt(length - 2);
      final String toCurrency = symbolParts.elementAt(length - 1);
      return ResponseWebSocketEntity(
        fromCurrency: FromCurrencyEnum.values.firstWhereOrNull(
          (element) => element.name.toLowerCase() == fromCurrency.toLowerCase(),
        ),
        toCurrency: ToCurrencyEnum.values.firstWhereOrNull(
          (element) => element.name.toLowerCase() == toCurrency.toLowerCase(),
        ),
        price: remoteModel.price,
        time: DateTime.parse(remoteModel.timeExchange),
      );
    } else {
      return ResponseWebSocketEntity(
        fromCurrency: null,
        toCurrency: null,
        price: remoteModel.price,
        time: DateTime.parse(remoteModel.timeExchange),
      );
    }
  }

  final FromCurrencyEnum? fromCurrency;
  final ToCurrencyEnum? toCurrency;
  final num price;
  final DateTime time;
}
