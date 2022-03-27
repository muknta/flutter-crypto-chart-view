import 'package:charts_flutter/flutter.dart' as charts;
import 'package:crypto_chart_view/presentation/blocs/main_bloc/bloc.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_chart_view_model.dart';
import 'package:crypto_chart_view/presentation/widgets/simplifiers/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeRatesTimeSeriesChart extends StatefulWidget {
  const ExchangeRatesTimeSeriesChart({
    Key? key,
    this.animate = true,
  }) : super(key: key);

  final bool animate;

  @override
  State<ExchangeRatesTimeSeriesChart> createState() => _ExchangeRatesTimeSeriesChartState();
}

class _ExchangeRatesTimeSeriesChartState extends State<ExchangeRatesTimeSeriesChart> {
  late MainBloc _bloc;
  late List<charts.Series<dynamic, DateTime>> _seriesList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<MainBloc>(context);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ExchangeRateChartViewState>(
      stream: _bloc.exchangeRatesTimeSeriesStream,
      builder: (context, chartSnap) {
        if (!chartSnap.hasData) {
          return const Loader();
        }
        _seriesList = [
          charts.Series<ExchangeRateChartViewModel, DateTime>(
            id: 'Lowest Exchange Rates',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (ExchangeRateChartViewModel chartModel, _) => chartModel.dateTime,
            measureFn: (ExchangeRateChartViewModel chartModel, _) => chartModel.lowestRate,
            data: chartSnap.data!.chartViewModels,
          ),
          charts.Series<ExchangeRateChartViewModel, DateTime>(
            id: 'Highest Exchange Rates',
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            domainFn: (ExchangeRateChartViewModel chartModel, _) => chartModel.dateTime,
            measureFn: (ExchangeRateChartViewModel chartModel, _) => chartModel.highestRate,
            data: chartSnap.data!.chartViewModels,
          ),
          charts.Series<ExchangeRateChartViewModel, DateTime>(
            id: 'Latest Exchange Rates',
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
            domainFn: (ExchangeRateChartViewModel chartModel, _) => chartModel.dateTime,
            measureFn: (ExchangeRateChartViewModel chartModel, _) => chartModel.lastRate,
            data: chartSnap.data!.chartViewModels,
          ),
        ];
        return charts.TimeSeriesChart(
          _seriesList,
          animate: widget.animate,
          // Optionally pass in a [DateTimeFactory] used by the chart. The factory
          // should create the same type of [DateTime] as the data provided. If none
          // specified, the default creates local date time.
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        );
      });
}
