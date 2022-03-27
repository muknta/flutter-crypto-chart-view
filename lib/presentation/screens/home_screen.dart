import 'package:crypto_chart_view/presentation/widgets/layout/actual_data_widget.dart';
import 'package:crypto_chart_view/presentation/widgets/layout/currency_form.dart';
import 'package:crypto_chart_view/presentation/widgets/layout/exchange_rates_time_series_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: const [
                CurrencyForm(),
                SizedBox(height: 20.0),
                ActualDataWidget(),
                SizedBox(height: 30.0),
                Expanded(
                  child: ExchangeRatesTimeSeriesChart(),
                ),
              ],
            ),
          ),
        ),
      );
}
