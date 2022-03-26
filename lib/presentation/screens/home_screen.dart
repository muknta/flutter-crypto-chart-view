import 'dart:convert';

import 'package:crypto_chart_view/presentation/widgets/actual_data_widget.dart';
import 'package:crypto_chart_view/presentation/widgets/currency_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_chart_view/internal/services/locator.dart';
import 'package:crypto_chart_view/presentation/blocs/main_bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._title, {Key? key}) : super(key: key);

  final String _title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MainBloc _mainBloc;
  final _formKey = GlobalKey<FormState>();

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
    _mainBloc = Provider.of<MainBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              CurrencyForm(),
              ActualDataWidget(),
            ],
          ),
        ),
      );
}
