import 'package:dio/dio.dart';

/// https://github.com/flutterchina/dio/issues/1228
class DioErrorInterceptor extends Interceptor {
  @override
  // ignore: avoid_renaming_method_parameters
  Future onError(DioError dioError, ErrorInterceptorHandler handler) {
    super.onError(dioError, handler);
    return Future.value(dioError);
  }
}
