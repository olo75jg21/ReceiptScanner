import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Successfully logged in!',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Successfully logged in!'),
        ),
        body: const Center(
          child: Text('Successfully logged in!'),
        ),
      ),
    );
  }
}
