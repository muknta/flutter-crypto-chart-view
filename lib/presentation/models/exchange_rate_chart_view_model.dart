import 'package:equatable/equatable.dart';

class ExchangeRateChartViewModel extends Equatable {
  const ExchangeRateChartViewModel({required this.dateTime, required this.rate});

  final DateTime dateTime;
  final double rate;

  @override
  List<Object?> get props => [dateTime, rate];
}
