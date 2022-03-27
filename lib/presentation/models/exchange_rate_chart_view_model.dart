import 'package:equatable/equatable.dart';

class ExchangeRateChartViewModel extends Equatable {
  const ExchangeRateChartViewModel({
    required this.dateTime,
    required this.lowestRate,
    required this.highestRate,
    required this.lastRate,
  });

  final DateTime dateTime;
  final double lowestRate;
  final double highestRate;
  final double lastRate;

  @override
  List<Object?> get props => [dateTime, lowestRate, highestRate, lastRate];
}
