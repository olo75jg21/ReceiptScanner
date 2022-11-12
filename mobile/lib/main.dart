import 'package:flutter/material.dart';
import '/view/login_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'ReceiptScanner',
        debugShowCheckedModeBanner: false,
        home: LoginView());
  }
}
