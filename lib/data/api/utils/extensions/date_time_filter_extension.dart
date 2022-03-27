extension DateTimeFilterExtension on DateTime {
  String get toFilteredIso6801String => toUtc().toIso8601String().split('.').elementAt(0).split('+').elementAt(0);
}
