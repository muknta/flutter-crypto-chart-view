import 'dart:convert';

import 'package:charts_flutter/flutter.dart';
import 'package:crypto_chart_view/presentation/widgets/layout/actual_data_widget.dart';
import 'package:crypto_chart_view/presentation/widgets/layout/currency_form.dart';
import 'package:crypto_chart_view/presentation/widgets/layout/historical_data_chart.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CurrencyForm(),
                const SizedBox(height: 20.0),
                const ActualDataWidget(),
                const SizedBox(height: 30.0),
                Expanded(
                  child: HistoricalDataChart.withSampleData(),
                ),
              ],
            ),
          ),
        ),
      );
}
