# Exchange rates of Crypto Currencies
This app fetches a cryptocurrency exchange rates API from [CoinAPI](https://docs.coinapi.io) using WebSocket API for real-time data and REST API for historical chart data.

Main features:
- Ability to change currencies
- Interactive graph
- Sembast NoSQL storage
- WebSocket protocol for real-time data
- HTTPS protocol for historical graph data

## Structure
Project divided by four structure levels (data, domain (business-logic), internal, presentation).

## Running
```bash
$ git clone https://github.com/heknt/flutter-crypto-chart-view.git
$ cd flutter-crypto-chart-view
```
Set your own [CoinAPI appKey](https://docs.coinapi.io/) in project [service config](https://github.com/heknt/flutter-crypto-chart-view/blob/master/lib/data/api/utils/services/settings/config.dart)

Connect your phone to computer and enable USB debugging. Next:
```bash
flutter-crypto-chart-view$ flutter doctor
flutter-crypto-chart-view$ flutter pub get
flutter-crypto-chart-view$ flutter pub run build_runner build --delete-conflicting-outputs
flutter-crypto-chart-view$ flutter run
```
