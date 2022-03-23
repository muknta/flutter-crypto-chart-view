import 'package:crypto_chart_view/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IRemoteRepository)
class RemoteRepository implements IRemoteRepository {
  const RemoteRepository({required IRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final IRemoteDataSource _remoteDataSource;
}
