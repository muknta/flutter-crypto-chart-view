import 'package:collection/collection.dart';

enum FromCurrencyEnum {
  bnt,
  btc,
  eos,
  eth,
  ltc,
  usdt,
}

enum ToCurrencyEnum {
  eur,
  gbp,
  usd,
}

const FromCurrencyEnum defaultFromCurrency = FromCurrencyEnum.btc;
const ToCurrencyEnum defaultToCurrency = ToCurrencyEnum.usd;

extension FromCurrencyEnumExtension on FromCurrencyEnum {
  String get uppercasedName => name.toUpperCase();
}

extension ToCurrencyEnumExtension on ToCurrencyEnum {
  String get uppercasedName => name.toUpperCase();

  String get symbol {
    switch (this) {
      case ToCurrencyEnum.eur:
        return '€';
      case ToCurrencyEnum.gbp:
        return '£';
      case ToCurrencyEnum.usd:
        return '\$';
    }
  }
}

extension StringCurrencyExtension on String {
  FromCurrencyEnum? get fromCurrencyEnumValue => FromCurrencyEnum.values.firstWhereOrNull(
        (element) => element.uppercasedName == toUpperCase(),
      );

  ToCurrencyEnum? get toCurrencyEnumValue => ToCurrencyEnum.values.firstWhereOrNull(
        (element) => element.uppercasedName == toUpperCase(),
      );
}

List<String> get fromCurrencyUppercasedNames => FromCurrencyEnum.values
    .map(
      (value) => value.uppercasedName,
    )
    .toList();

List<String> get toCurrencyUppercasedNames => ToCurrencyEnum.values
    .map(
      (value) => value.uppercasedName,
    )
    .toList();

List<List<String>>? _currencyPairs;
List<List<String>> get currencyPairs => _currencyPairs ??= List.generate(
      FromCurrencyEnum.values.length * ToCurrencyEnum.values.length,
      (i) {
        for (int j = 0; j < ToCurrencyEnum.values.length; j++) {
          return <String>[
            FromCurrencyEnum.values.elementAt(i).uppercasedName,
            ToCurrencyEnum.values.elementAt(j).uppercasedName,
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
