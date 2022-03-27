import 'package:crypto_chart_view/presentation/blocs/main_bloc/bloc.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:crypto_chart_view/presentation/utils/resources/theme.dart';
import 'package:crypto_chart_view/presentation/widgets/animation/animated_button.dart';
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
              flex: 6,
              child: _FormItemColumn(
                title: 'From:',
                child: _DropdownListWidget(
                  values: fromCurrencyUppercasedNames,
                  onChoose: (String value) => _bloc.addEvent(SetFromCurrencyEvent(value: value)),
                  stream: _bloc.fromCurrencySwitcherStream,
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 6,
              child: _FormItemColumn(
                title: 'To:',
                child: _DropdownListWidget(
                  values: toCurrencyUppercasedNames,
                  onChoose: (String value) => _bloc.addEvent(SetToCurrencyEvent(value: value)),
                  stream: _bloc.toCurrencySwitcherStream,
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 8,
              child: _FormItemColumn(
                /// Add empty string for general Form Row crossAxisAlignment
                title: '',
                child: AnimatedButton(
                  title: 'Subscribe',
                  onTap: () {
                    showSnackBar(context, title: 'Processing actual data');
                    _bloc.addEvent(const DataRequestEvent());
                  },
                ),
              ),
            ),
          ],
        ),
      );
}

class _FormItemColumn extends StatelessWidget {
  const _FormItemColumn({
    required String title,
    required Widget child,
  })  : _title = title,
        _child = child;

  final String _title;
  final Widget _child;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(_title),
          ),
          _child,
        ],
      );
}

class _DropdownListWidget extends StatelessWidget {
  const _DropdownListWidget({
    required List<String> values,
    required void Function(String) onChoose,
    required Stream<ActualDataState> stream,
  })  : _values = values,
        _onChoose = onChoose,
        _stream = stream;

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
        return InputDecorator(
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            errorStyle: const TextStyle(color: Colors.redAccent),
            hintText: 'Please, select currency',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          ),
          child: DropdownButtonHideUnderline(
            // TODO: DropdownButtonFormField
            child: DropdownButton<String>(
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
          ),
        );
      });
}
