import 'package:crypto_chart_view/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  const LocalDataSource();
}
