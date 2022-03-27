import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends MainEvent {
  const InitialEvent();
}

abstract class ActualDataEvent extends MainEvent {
  const ActualDataEvent();
}

class SetFromCurrencyEvent extends ActualDataEvent {
  const SetFromCurrencyEvent({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [value];
}

class SetToCurrencyEvent extends ActualDataEvent {
  const SetToCurrencyEvent({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [value];
}

class DataRequestEvent extends MainEvent {
  const DataRequestEvent();
}
