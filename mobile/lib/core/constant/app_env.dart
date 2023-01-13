// Class desired to store environment config data

class AppEnv {
  static const Map<String, String> defaultHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static const String url =
      'http://http://10.0.2.2:3000'; //'http://10.0.2.2:3000';
  static const String env = 'local';
  static const bool debug = true;
}
