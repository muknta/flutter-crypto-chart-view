import 'package:crypto_chart_view/presentation/blocs/main_bloc/bloc.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyForm extends StatefulWidget {
  const CurrencyForm({Key? key}) : super(key: key);

  @override
  _CurrencyFormState createState() => _CurrencyFormState();
}

class _CurrencyFormState extends State<CurrencyForm> {
  final _formKey = GlobalKey<FormState>();
  late MainBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<MainBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: _DropdownListWidget(
                title: 'From:',
                values: fromCurrencyUppercasedNames,
                onChoose: (String value) {
                  print('aaaa2223a');
                  _bloc.addEvent(SetFromCurrencyEvent(value: value));
                },
                stream: _bloc.fromCurrencySwitcherStream,
              ),
            ),
            Spacer(),
            Expanded(
              child: _DropdownListWidget(
                title: 'To:',
                values: toCurrencyUppercasedNames,
                onChoose: (String value) => _bloc.addEvent(SetToCurrencyEvent(value: value)),
                stream: _bloc.toCurrencySwitcherStream,
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing data')),
                  );
                  _bloc.addEvent(const ActualDataRequestEvent());
                },
                child: const Text('Subscribe'),
              ),
            ),
          ],
        ),
      );
}

class _DropdownListWidget extends StatelessWidget {
  const _DropdownListWidget({
    required String title,
    required List<String> values,
    required void Function(String) onChoose,
    required Stream<ActualDataState> stream,
  })  : _title = title,
        _values = values,
        _onChoose = onChoose,
        _stream = stream;

  final String _title;
  final List<String> _values;
  final void Function(String) _onChoose;
  final Stream<ActualDataState> _stream;

  @override
  Widget build(BuildContext context) => StreamBuilder<ActualDataState>(
      stream: _stream,
      builder: (context, snapshot) {
        String? dropdownValue;
        if (snapshot.data is FromCurrencySwitcherState) {
          dropdownValue = (snapshot.data as FromCurrencySwitcherState).value.toUpperCase();
        } else if (snapshot.data is ToCurrencySwitcherState) {
          dropdownValue = (snapshot.data as ToCurrencySwitcherState).value.toUpperCase();
        }
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _title,
                textAlign: TextAlign.left,
              ),
            ),
            // InputDecorator(
            //   decoration: InputDecoration(
            //     labelStyle: TextStyle(color: Colors.black),
            //     errorStyle: TextStyle(color: Colors.redAccent),
            //     hintText: 'Please, select currency',
            //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            //   ),
            //   child:
            // DropdownButtonHideUnderline(
            //   child:
            DropdownButton<String>(
              value: dropdownValue,
              items: _values.map((String value) {
                return DropdownMenuItem<String>(
                  value: value.toUpperCase(),
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  _onChoose(value.toUpperCase());
                }
              },
            ),
            // ),
            // ),
          ],
        );
      });
}
