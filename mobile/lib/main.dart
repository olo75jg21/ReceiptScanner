import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/service/file_io_service.dart';
import 'package:mobile/view/authentication/login_view.dart';
import 'package:mobile/view/profile/main_profile_view.dart';
import 'package:mobile/view/test_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory(await FileIO.localPath('scans')).createSync();

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
    return const MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text(appTitle),
      //   ),
      //   body: LoginForm(),
      // ),
      home: MainProfileView(),
    );
  }
}
