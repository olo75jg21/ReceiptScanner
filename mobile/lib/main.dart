import 'package:flutter/material.dart';
import '/view/login_view.dart';
import 'package:mobile/product/form/login_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'ReceiptScanner';

    // return MaterialApp(
    //   title: appTitle,
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(appTitle),
    //     ),
    //     body: const MyCustomForm(),
    //   ),
    // );
    return MaterialApp(
      title: 'ReceiptScanner',
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text(appTitle),
      //   ),
      //   body: const LoginForm(),
      // ),
      home: LoginView(),
    );
  }
}
