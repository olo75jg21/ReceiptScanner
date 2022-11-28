import '/core/constant/app_env.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static const String _url = AppEnv.url;

  // sends POST request to given route with given body
  // returns HTTP response
  static Future<http.Response> post(String route, String body) async {
    final response = await http.post(
      Uri.parse('$_url/$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return response;
  }
}
