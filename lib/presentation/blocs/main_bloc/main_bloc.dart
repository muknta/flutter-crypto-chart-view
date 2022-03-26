import 'dart:async';

import 'package:crypto_chart_view/domain/entities/request_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/entities/response_web_socket_entity.dart';
import 'package:crypto_chart_view/domain/use_cases/remote_use_cases/get_socket_response_stream.dart';
import 'package:crypto_chart_view/domain/use_cases/remote_use_cases/set_socket_request.dart';
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
        await SetSocketRequest(remoteRepository: _remoteRepository).execute(
          params: const RequestWebSocketEntity(
            fromCurrency: FromCurrencyEnum.btc,
            toCurrency: ToCurrencyEnum.usd,
          ),
        );
      } else if (event is ActualDataEvent) {
        if (event is ActualDataRequestEvent) {
          if (isStreamHasValue(_fromCurrencySwitcherStateController) &&
              isStreamHasValue(_toCurrencySwitcherStateController)) {
            final FromCurrencyEnum? fromCurrency =
                _fromCurrencySwitcherStateController.value.value.fromCurrencyEnumValue;
            final ToCurrencyEnum? toCurrency = _toCurrencySwitcherStateController.value.value.toCurrencyEnumValue;
            if (fromCurrency != null && toCurrency != null) {
              await SetSocketRequest(remoteRepository: _remoteRepository).execute(
                params: RequestWebSocketEntity(
                  fromCurrency: fromCurrency,
                  toCurrency: toCurrency,
                ),
              );
            }
          }
        } else if (event is SetFromCurrencyEvent) {
          _setFromCurrencySwitcherState(FromCurrencySwitcherState(value: event.value));
        } else if (event is SetToCurrencyEvent) {
          _setToCurrencySwitcherState(ToCurrencySwitcherState(value: event.value));
        }
      } else if (event is HistoricalDataRequestEvent) {}
    }
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
