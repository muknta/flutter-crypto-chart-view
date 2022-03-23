import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_chart_view/internal/services/locator.dart';
import 'package:crypto_chart_view/presentation/blocs/main_bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._title, {Key? key}) : super(key: key);

  final String _title;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late MainBloc mainBloc;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context);
}
