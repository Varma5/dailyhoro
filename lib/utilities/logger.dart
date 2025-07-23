import 'dart:developer';

import '../environment/base_config.dart';
import '../environment/environment.dart';

class Logger {
  static void doLog(dynamic val) {
    if (Environment().config is DevConfig) {
      log(val.toString());
    }
  }
}
