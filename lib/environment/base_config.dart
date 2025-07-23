abstract class BaseConfig {
  String get apiHost;

  String get socketHost;
}

class DevConfig implements BaseConfig {
  @override
  String get apiHost => "http://192.168.2.162:5459/api/v1/";

  @override
  String get socketHost => "http://192.168.2.162:5459/";
}

class UATConfig implements BaseConfig {
  @override
  String get apiHost => "http://192.168.2.162:5459/api/v1/";

  @override
  String get socketHost => "http://192.168.2.162:5459/";
}

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "http://192.168.2.162:5459/api/v1/";

  @override
  String get socketHost => "http://192.168.2.162:5459/";
}
