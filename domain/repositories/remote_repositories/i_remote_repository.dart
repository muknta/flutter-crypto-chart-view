import 'package:crypto_chart_view/domain/model/day/day.dart';
import 'package:crypto_chart_view/domain/model/hour/hour.dart';

abstract class IRemoteRepository {
  const IRemoteRepository();

  Future<List<Day>> fetchDailyContent({
    required double latitude,
    required double longitude,
    required String language,
  });

  Future<List<Hour>> fetchHourlyContent({
    required double latitude,
    required double longitude,
    required String language,
  });
}
