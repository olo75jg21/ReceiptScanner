import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email, this.password);

  static Future<http.Response> registerUser(Map<String, dynamic> credentials) {
    return http.post(
      Uri.parse('localhost:3000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': '${credentials['first_name']} ${credentials['last_name']}',
        'email': credentials['email'],
        'password': credentials['password']
      }),
    );
  }

  // NOTE: implementing functionality here in the next step!
}
