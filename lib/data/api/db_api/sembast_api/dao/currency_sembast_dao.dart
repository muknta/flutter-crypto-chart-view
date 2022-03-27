import 'package:crypto_chart_view/data/api/db_api/sembast_api/schemas/currency_sembast_schema.dart';
import 'package:crypto_chart_view/data/api/db_api/sembast_api/sembast_database.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

@LazySingleton()
class CurrencySembastDao {
  static const storePath = 'currency';

  Future<Database> get _database => SembastDatabase.instance.database;
  final settingsFolder = intMapStoreFactory.store(storePath);

  Future<String?> getFromCurrency() async {
    final Finder finder =
        Finder(filter: Filter.equals(CurrencySembastSchema.param, CurrencySembastSchemaKeys.fromCurrency));
    final record = await settingsFolder.findFirst(await _database, finder: finder);
    return record?.value[CurrencySembastSchema.value] as String?;
  }

  Future<String?> getToCurrency() async {
    final Finder finder =
        Finder(filter: Filter.equals(CurrencySembastSchema.param, CurrencySembastSchemaKeys.toCurrency));
    final record = await settingsFolder.findFirst(await _database, finder: finder);
    return record?.value[CurrencySembastSchema.value] as String?;
  }

  Future<bool> setFromCurrency(String fromCurrency) async {
    final Finder finder =
        Finder(filter: Filter.equals(CurrencySembastSchema.param, CurrencySembastSchemaKeys.fromCurrency));
    final record = await settingsFolder.findFirst(await _database, finder: finder);
    if (record == null) {
      final res = await settingsFolder.add(await _database, <String, dynamic>{
        CurrencySembastSchema.param: CurrencySembastSchemaKeys.fromCurrency,
        CurrencySembastSchema.value: fromCurrency,
      });
      return res != SembastDatabase.negativeResultValue;
    }
    return await settingsFolder.update(
            await _database,
            <String, dynamic>{
              CurrencySembastSchema.param: CurrencySembastSchemaKeys.fromCurrency,
              CurrencySembastSchema.value: fromCurrency,
            },
            finder: finder) !=
        SembastDatabase.negativeResultValue;
  }

  Future<bool> setToCurrency(String toCurrency) async {
    final Finder finder =
        Finder(filter: Filter.equals(CurrencySembastSchema.param, CurrencySembastSchemaKeys.toCurrency));
    final record = await settingsFolder.findFirst(await _database, finder: finder);
    if (record == null) {
      final res = await settingsFolder.add(await _database, <String, dynamic>{
        CurrencySembastSchema.param: CurrencySembastSchemaKeys.toCurrency,
        CurrencySembastSchema.value: toCurrency,
      });
      return res != SembastDatabase.negativeResultValue;
    }
    return await settingsFolder.update(
            await _database,
            <String, dynamic>{
              CurrencySembastSchema.param: CurrencySembastSchemaKeys.toCurrency,
              CurrencySembastSchema.value: toCurrency,
            },
            finder: finder) !=
        SembastDatabase.negativeResultValue;
  }
}
