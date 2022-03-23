import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/interna/services/locator.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  static const _title = 'Crypto Chart';

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<MainBloc>(
            create: (_) => MainBloc(
              remoteRepository: locator<IRemoteRepository>(),
              localRepository: locator<ILocalRepository>(),
            )..addEvent(const InitialEvent()),
            dispose: (_, MainBloc mainBloc) => mainBloc.dispose(),
          ),
        ],
        child: MaterialApp(
          title: _title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomeScreen(_title),
        ),
      );
}
