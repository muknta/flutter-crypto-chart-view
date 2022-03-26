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
              flex: 3,
              child:
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a currency';
                  }
                  return value;
                },
              ),
              //   DropdownButtonHideUnderline(
              //           child: DropdownButton<String>(
              //             value: combinedCurrencyPairs.first,
              //             isDense: true,
              //             onChanged: (String? newValue) {
              //             },
              //             items: combinedCurrencyPairs.map((String value) {
              //               return DropdownMenuItem<String>(
              //                 value: value,
              //                 child: Text(value),
              //               );
              //             }).toList(),
              //           ),
              //         ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
  _bloc.addEvent(ActualDataRequestEvent(fromCurrency: _formKey., toCurrency: toCurrency));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
        
      );
}
