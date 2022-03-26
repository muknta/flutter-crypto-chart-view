import 'package:collection/collection.dart';

enum FromCurrencyEnum {
  btc,
  eth,
}

enum ToCurrencyEnum {
  usd,
}

List<List<String>>? _currencyPairs;
List<List<String>> get currencyPairs => _currencyPairs ??= List.generate(
      FromCurrencyEnum.values.length * ToCurrencyEnum.values.length,
      (i) {
        for (int j = 0; j < ToCurrencyEnum.values.length; j++) {
          return <String>[
            FromCurrencyEnum.values.elementAt(i).name.toUpperCase(),
            ToCurrencyEnum.values.elementAt(j).name.toUpperCase(),
          ];
        }
        return [];
      },
    );

List<String>? _combinedCurrencyPairs;
List<String> combinedCurrencyPairs = _combinedCurrencyPairs ??= currencyPairs
    .map<String>(
      (pairList) => pairList.join('/'),
    )
    .toList();

const toCurrencySymbolMap = <ToCurrencyEnum, String>{
  ToCurrencyEnum.usd: '\$',
};

FromCurrencyEnum? getFromCurrencyEnumFromString(String value) => FromCurrencyEnum.values.firstWhereOrNull(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
    );

ToCurrencyEnum? getToCurrencyEnumFromString(String value) => ToCurrencyEnum.values.firstWhereOrNull(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
    );
