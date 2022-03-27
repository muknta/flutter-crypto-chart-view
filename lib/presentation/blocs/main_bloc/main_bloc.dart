import 'dart:async';

import 'package:crypto_chart_view/domain/entities/time_series/exchange_rate_time_series_entity.dart';
import 'package:crypto_chart_view/domain/entities/web_socket/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/entities/web_socket/response_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/use_cases/remote_use_cases/time_series/get_exchange_rates_time_series.dart';
import 'package:crypto_chart_view/domain/use_cases/remote_use_cases/web_socket/get_socket_response_stream.dart';
import 'package:crypto_chart_view/domain/use_cases/remote_use_cases/web_socket/set_socket_request.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_chart_view_model.dart';
import 'package:crypto_chart_view/presentation/models/exchange_rate_model.dart';
import 'package:crypto_chart_view/presentation/utils/enums/currency_enum.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:crypto_chart_view/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:crypto_chart_view/domain/repositories/remote_repositories/i_remote_repository.dart';
import 'package:crypto_chart_view/presentation/utils/mixins/bloc_stream_mixin.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc with BlocStreamMixin {
  MainBloc({
    required IRemoteRepository remoteRepository,
    required ILocalRepository localRepository,
  })  : _remoteRepository = remoteRepository,
        _localRepository = localRepository {
    _eventController.listen(_handleEvent);
  }

  final IRemoteRepository _remoteRepository;
  final ILocalRepository _localRepository;

  static const String _defaultFromCurrencyStringValue = 'BTC';
  static const String _defaultToCurrencyStringValue = 'USD';

  final _eventController = BehaviorSubject<MainEvent>();
  Function(MainEvent) get addEvent => sinkAdd(_eventController);

  final _fromCurrencySwitcherStateController = BehaviorSubject<FromCurrencySwitcherState>.seeded(
      const FromCurrencySwitcherState(value: _defaultFromCurrencyStringValue));
  Stream<FromCurrencySwitcherState> get fromCurrencySwitcherStream => _fromCurrencySwitcherStateController.stream;
  Function(FromCurrencySwitcherState) get _setFromCurrencySwitcherState =>
      sinkAdd(_fromCurrencySwitcherStateController);

  final _toCurrencySwitcherStateController = BehaviorSubject<ToCurrencySwitcherState>.seeded(
      const ToCurrencySwitcherState(value: _defaultToCurrencyStringValue));
  Stream<ToCurrencySwitcherState> get toCurrencySwitcherStream => _toCurrencySwitcherStateController.stream;
  Function(ToCurrencySwitcherState) get _setToCurrencySwitcherState => sinkAdd(_toCurrencySwitcherStateController);

  final _exchangeRatesTimeSeriesStateController = BehaviorSubject<ExchangeRateChartViewState>();
  Stream<ExchangeRateChartViewState> get exchangeRatesTimeSeriesStream =>
      _exchangeRatesTimeSeriesStateController.stream;
  Function(ExchangeRateChartViewState) get _setExchangeRatesTimeSeriesState =>
      sinkAdd(_exchangeRatesTimeSeriesStateController);

  Stream<LoadedActualDataState>? _actualDataStateStream;
  Stream<LoadedActualDataState> get actualDataStateStream =>
      _actualDataStateStream ??= GetSocketResponseStream(remoteRepository: _remoteRepository).execute().transform(
            _streamTransformer,
          );
  final _streamTransformer = StreamTransformer<ResponseWebSocketEntity, LoadedActualDataState>.fromHandlers(
    handleData: (ResponseWebSocketEntity data, EventSink<LoadedActualDataState> sink) {
      sink.add(LoadedActualDataState(responseEntity: data));
    },
  );

  Future<void> _handleEvent(dynamic event) async {
    if (event is MainEvent) {
      if (event is InitialEvent) {
        final FromCurrencyEnum? fromCurrency = _defaultFromCurrencyStringValue.fromCurrencyEnumValue;
        final ToCurrencyEnum? toCurrency = _defaultToCurrencyStringValue.toCurrencyEnumValue;
        if (fromCurrency != null && toCurrency != null) {
          await _loadNewData(
            exchangeRate: ExchangeRateModel(
              fromCurrency: fromCurrency,
              toCurrency: toCurrency,
            ),
          );
        }
      } else if (event is ActualDataEvent) {
        if (event is SetFromCurrencyEvent) {
          _setFromCurrencySwitcherState(FromCurrencySwitcherState(value: event.value));
        } else if (event is SetToCurrencyEvent) {
          _setToCurrencySwitcherState(ToCurrencySwitcherState(value: event.value));
        }
      } else if (event is DataRequestEvent) {
        final ExchangeRateModel? exchangeRate = _getExchangeRateModel();
        if (exchangeRate != null) {
          await _loadNewData(exchangeRate: exchangeRate);
        }
      }
    }
  }

  Future<void> _loadNewData({required ExchangeRateModel exchangeRate}) async {
    await _setSocketRequest(exchangeRate: exchangeRate);
    await _setExchangeRatesChartView(exchangeRate: exchangeRate);
  }

  Future<void> _setSocketRequest({required ExchangeRateModel exchangeRate}) async {
    await SetSocketRequest(remoteRepository: _remoteRepository).execute(
        params: RequestWebSocketEntity(
      exchangeRateModel: ExchangeRateModel(
        fromCurrency: exchangeRate.fromCurrency,
        toCurrency: exchangeRate.toCurrency,
      ),
    ));
  }

  Future<void> _setExchangeRatesChartView({required ExchangeRateModel exchangeRate}) async {
    final List<ExchangeRateTimeSeriesEntity> exchangeRateEntities =
        await GetExchangeRatesTimeSeries(remoteRepository: _remoteRepository).execute(params: exchangeRate);
    final chartViewModels = <ExchangeRateChartViewModel>[];
    exchangeRateEntities.map((entity) {
      print('time ${entity.lastTradeTime} === rate ${entity.lastTradeRate.toDouble()}');
      chartViewModels.add(ExchangeRateChartViewModel(
        dateTime: entity.lastTradeTime,
        rate: entity.lastTradeRate.toDouble(),
      ));
    }).toList();
    _setExchangeRatesTimeSeriesState(ExchangeRateChartViewState(
      chartViewModels: chartViewModels,
    ));
  }

  ExchangeRateModel? _getExchangeRateModel() {
    if (isStreamHasValue(_fromCurrencySwitcherStateController) &&
        isStreamHasValue(_toCurrencySwitcherStateController)) {
      final FromCurrencyEnum? fromCurrency = _fromCurrencySwitcherStateController.value.value.fromCurrencyEnumValue;
      final ToCurrencyEnum? toCurrency = _toCurrencySwitcherStateController.value.value.toCurrencyEnumValue;
      if (fromCurrency != null && toCurrency != null) {
        return ExchangeRateModel(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        );
      }
    }
    return null;
  }

  @override
  void dispose() {
    if (isStreamNotClosed(_eventController)) {
      _eventController.close();
    }
    if (isStreamNotClosed(_fromCurrencySwitcherStateController)) {
      _fromCurrencySwitcherStateController.close();
    }
    if (isStreamNotClosed(_toCurrencySwitcherStateController)) {
      _toCurrencySwitcherStateController.close();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
