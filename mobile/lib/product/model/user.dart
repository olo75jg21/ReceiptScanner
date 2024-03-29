import '/core/utility/http_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;
  final String email;
  final String password;

  const User(
      {required this.username, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  static Future<User> registerUser(Map<String, dynamic> credentials) async {
    http.Response response = await HttpClient.post('register',
        body: jsonEncode(<String, String>{
          'username':
              '${credentials['first_name']} ${credentials['last_name']}',
          'email': credentials['email'],
          'password': credentials['password']
        }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      // print('response code: response.statusCode');
      // print(response.body);

      throw Exception('Failed to create User.');
    }
  }
  // NOTE: implementing functionality here in the next step!
}
