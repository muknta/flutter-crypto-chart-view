import 'package:crypto_chart_view/data/api/utils/enums/period_id_request_time_series_enum.dart';

// General
const String serviceApiKey = "";

// REST API
const String restApiProductionBaseUrl = 'https://rest.coinapi.io';
const String restApiSandboxBaseUrl = 'https://rest-sandbox.coinapi.io';

const PeriodIdRequestTimeSeriesEnum defaultPeriodId = PeriodIdRequestTimeSeriesEnum.day1;
const int numberOfObservableDays = 60;

// WebSocket API
const String webSocketProductionBaseUrl = 'wss://ws.coinapi.io/v1';
const String webSocketSandboxBaseUrl = 'wss://ws-sandbox.coinapi.io/v1';

// example
// {time_exchange: 2022-03-26T04:08:37.7090940Z, time_coinapi: 2022-03-26T04:08:37.7770910Z, uuid: 09....a, price: 44491.07, size: 0.00215094, taker_side: BUY, symbol_id: COINBASE_SPOT_BTC_USD, sequence: 3813055, type: trade}
