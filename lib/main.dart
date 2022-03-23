import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_chart_view/internal/services/locator.dart';
import 'package:crypto_chart_view/internal/application.dart';
import 'package:crypto_chart_view/presentation/utils/resources/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();

  if (!isTablet()) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(const Application());
}
