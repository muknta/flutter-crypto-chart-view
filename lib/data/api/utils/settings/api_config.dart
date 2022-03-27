import 'package:crypto_chart_view/data/api/utils/enums/period_id_request_time_series_enum.dart';

// General
const String serviceApiKey = "";

// REST API
const String restApiProductionBaseUrl = 'https://rest-sandbox.coinapi.io';
const String restApiSandboxBaseUrl = 'https://rest-sandbox.coinapi.io';

const PeriodIdRequestTimeSeriesEnum defaultPeriodId = PeriodIdRequestTimeSeriesEnum.day2;
const int numberOfObservableDays = 60;

// WebSocket API
const String webSocketProductionBaseUrl = 'wss://ws.coinapi.io/v1';
const String webSocketSandboxBaseUrl = 'wss://ws-sandbox.coinapi.io/v1';

// NoSQL DB API
const String sembastDBName = 'sembast.db';
