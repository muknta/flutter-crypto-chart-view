import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:crypto_chart_view/presentation/blocs/main_bloc/bloc.dart';

class ActualDataWidget extends StatefulWidget {
  const ActualDataWidget({Key? key}) : super(key: key);

  @override
  _ActualDataWidgetState createState() => _ActualDataWidgetState();
}

class _ActualDataWidgetState extends State<ActualDataWidget> {
  late MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mainBloc = Provider.of<MainBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<LoadedActualDataState>(
        stream: _mainBloc.actualDataStateStream,
        builder: (context, socketSnap) {
          if (!socketSnap.hasData) {
            return const SizedBox.shrink();
          }
          final FromCurrencyEnum? fromCurrency = socketSnap.data!.responseEntity.fromCurrency;
          final ToCurrencyEnum? toCurrency = socketSnap.data!.responseEntity.toCurrency;
          final num price = socketSnap.data!.responseEntity.price;
          final DateTime time = socketSnap.data!.responseEntity.time;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (fromCurrency != null && toCurrency != null)
                _CurrencyParameterWidget(
                  title: 'Symbol:',
                  value: '${fromCurrency.name.toUpperCase()}/${toCurrency.name.toUpperCase()}',
                ),
              _CurrencyParameterWidget(
                title: 'Price:',
                value: '${toCurrencySymbolMap[toCurrency]} $price',
              ),
              _CurrencyParameterWidget(
                title: 'Time:',
                value: DateFormat('kk:mm:ss / dd.MM.yyyy').format(time),
              ),
            ],
          );
        },
      );
}

class _CurrencyParameterWidget extends StatelessWidget {
  const _CurrencyParameterWidget({required String title, required String? value})
      : _title = title,
        _value = value;

  final String _title;
  final String? _value;

  @override
  Widget build(BuildContext context) => _value == null
      ? const SizedBox.shrink()
      : Column(
          children: [
            AutoSizeText(_title),
            AutoSizeText(_value!),
          ],
        );
}
