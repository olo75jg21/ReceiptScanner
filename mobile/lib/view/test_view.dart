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
        body: Center(
          child: Column(
            children: [
              const Text('Successfully logged in!'),
              TextButton(
                child: const Text(
                  'Camera',
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(
                  //       // builder: (context) => CameraView(camera: _firstCamera)),
                  // );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
