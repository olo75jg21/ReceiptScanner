import '/core/constant/app_env.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static const String _url = AppEnv.url;
  static const Duration _duration = Duration(seconds: 5);
  static const Map<String, String> _defaultHeader = AppEnv.defaultHeader;

  // sends POST request to given route with given body
  // returns HTTP response
  static Future<http.Response> post(String route,
      {String body = "", Map<String, String> headers = const {}}) async {
    final response = await http
        .post(
          Uri.parse('$_url/$route'),
          headers: {}
            ..addAll(_defaultHeader)
            ..addAll(headers),
          body: body,
        )
        .timeout(
          _duration,
        );
    return response;
  }

  // sends GET request to given route with given body
  // returns HTTP response
  static Future<http.Response> get(String route,
      {Map<String, String> headers = const {}}) async {
    final response = await http
        .get(
          Uri.parse('$_url/$route'),
          headers: {}
            ..addAll(_defaultHeader)
            ..addAll(headers),
        )
        .timeout(
          _duration,
        );
    return response;
  }
}
