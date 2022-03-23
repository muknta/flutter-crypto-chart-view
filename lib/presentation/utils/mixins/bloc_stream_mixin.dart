import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

mixin BlocStreamMixin<T> {
  Function(T) sinkAdd(StreamController<T>? streamController) => streamController?.isClosed ?? true
      ? (_) {
          assert(streamController != null, 'streamController is NULL / ControllerHelperMixin addFunction');
          debugPrint('${streamController.toString()} is Closed');
        }
      : streamController!.sink.add;

  bool isStreamNotClosed(Subject streamController) => !streamController.isClosed;
  bool isStreamHasValue(BehaviorSubject streamController) => !streamController.isClosed && streamController.hasValue;

  void dispose();
}

typedef SinkFunction<T> = void Function(T);
