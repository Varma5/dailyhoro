// ignore_for_file: constant_identifier_names

import 'package:dailyhoro/constants/const_keys.dart';
import 'base_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = ConstKeys.keyDEV;
  static const String UAT = ConstKeys.keyUAT;
  static const String PROD = ConstKeys.keyPROD;

  BaseConfig config = UATConfig();

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.UAT:
        return UATConfig();
      case Environment.DEV:
        return DevConfig();
      default:
        return UATConfig();
    }
  }
}
