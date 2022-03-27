import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate_time_series_remote_model.g.dart';

@JsonSerializable()
class ExchangeRateTimeSeriesRemoteModel {
  const ExchangeRateTimeSeriesRemoteModel({
    required this.timePeriodStart,
    required this.timePeriodEnd,
    required this.firstTradeTime,
    required this.lastTradeTime,
    required this.firstTradeRate,
    required this.highestRate,
    required this.lowestRate,
    required this.lastTradeRate,
  });

  factory ExchangeRateTimeSeriesRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateTimeSeriesRemoteModelFromJson(json);

  @JsonKey(name: 'time_period_start')
  final String timePeriodStart;

  @JsonKey(name: 'time_period_end')
  final String timePeriodEnd;

  @JsonKey(name: 'time_open')
  final String firstTradeTime;

  @JsonKey(name: 'time_close')
  final String lastTradeTime;

  @JsonKey(name: 'rate_open')
  final num firstTradeRate;

  @JsonKey(name: 'rate_high')
  final num highestRate;

  @JsonKey(name: 'rate_low')
  final num lowestRate;

  @JsonKey(name: 'rate_close')
  final num lastTradeRate;
}
