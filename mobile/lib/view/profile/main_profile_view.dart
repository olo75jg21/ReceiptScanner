import 'package:flutter/material.dart';

import '../test_view.dart';

class MainProfileView extends StatefulWidget {
  const MainProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfileView> {
  void _redirectToReceiptList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TestView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: _redirectToReceiptList,
                child: const Text('Receipts'))
          ],
        ),
      ),
    );
  }
}
