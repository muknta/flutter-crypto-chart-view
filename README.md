# Weather Getter
This app fetches a cryptocurrency exchange rates API from [CoinAPI](https://docs.coinapi.io) using WebSocket API for real-time data and REST API for historical chart data.

Main features:
- location detecting (program gets a weather API by coordinates)
- localization feature (choose between English and Russian)
- SQFLite storage
- API taking of daily, hourly

## Structure
Project divided by four structure levels (data, domain (business-logic), internal, presentation).

Presentation contains four screens:
- splash - with weather-logo (shown for several sec on app start, and you can tap on image to speed up the transition).
- home - main screen. Here is the main features, and two buttons (daily, hourly) which can open API by tap. There is showing weather information shortly.
- detailed day screen - screen with detailed day information.
- detailed hour - screen with detailed hour information.


## API
#### Types of taken API:
- daily - shows weather info of each day of the next week.
- hourly - shows weather info of each hour of the next two days.

#### Example of API
results in my project - [daily.json](https://github.com/heknt/flutter-weather-app/blob/master/lib/data/storage/daily.json) and [hourly.json](https://github.com/heknt/flutter-weather-app/blob/master/lib/data/storage/hourly.json)

## Running
```bash
$ git clone https://github.com/heknt/flutter-weather-app-2.0.git
$ cd flutter-weather-app-2.0
```
Set your own [openweathermap AppId](https://openweathermap.org/appid) in project [service config](https://github.com/heknt/flutter-weather-app-2.0/blob/master/lib/data/api/rest_api/services/settings/config.dart)

Connect your phone to computer and enable USB debugging. Next:
```bash
flutter-weather-app-2.0$ flutter doctor
flutter-weather-app-2.0$ flutter pub get
flutter-weather-app-2.0$ flutter pub run build_runner build --delete-conflicting-outputs
flutter-weather-app-2.0$ flutter run
```
