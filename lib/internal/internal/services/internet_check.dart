import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

Future<bool> isExistConnection() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  switch (connectivityResult) {
    case ConnectivityResult.mobile:
    case ConnectivityResult.wifi:
    case ConnectivityResult.ethernet:
      debugPrint('connection exists');
      return true;
    case ConnectivityResult.bluetooth:
    default:
      debugPrint('connection does NOT exist');
      return false;
  }
}
