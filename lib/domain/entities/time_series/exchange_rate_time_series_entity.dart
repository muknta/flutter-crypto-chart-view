import 'package:crypto_chart_view/data/api/models/remote_models/time_series/exchange_rate_time_series_remote_model.dart';

class ExchangeRateTimeSeriesEntity {
  const ExchangeRateTimeSeriesEntity({
    required this.timePeriodStart,
    required this.timePeriodEnd,
    required this.firstTradeTime,
    required this.lastTradeTime,
    required this.firstTradeRate,
    required this.highestRate,
    required this.lowestRate,
    required this.lastTradeRate,
  });

  factory ExchangeRateTimeSeriesEntity.fromRemoteModel({required ExchangeRateTimeSeriesRemoteModel remoteModel}) =>
      ExchangeRateTimeSeriesEntity(
        timePeriodStart: DateTime.parse(remoteModel.timePeriodStart),
        timePeriodEnd: DateTime.parse(remoteModel.timePeriodEnd),
        firstTradeTime: DateTime.parse(remoteModel.firstTradeTime),
        lastTradeTime: DateTime.parse(remoteModel.lastTradeTime),
        firstTradeRate: remoteModel.firstTradeRate,
        highestRate: remoteModel.highestRate,
        lowestRate: remoteModel.lowestRate,
        lastTradeRate: remoteModel.lastTradeRate,
      );

  final DateTime timePeriodStart;
  final DateTime timePeriodEnd;
  final DateTime firstTradeTime;
  final DateTime lastTradeTime;
  final num firstTradeRate;
  final num highestRate;
  final num lowestRate;
  final num lastTradeRate;
}
