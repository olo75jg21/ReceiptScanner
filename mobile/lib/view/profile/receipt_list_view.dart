import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/view/camera_view.dart';

class ReceiptListView extends StatelessWidget {
  ReceiptListView({Key? key}) : super(key: key);

  late List<CameraDescription> _cameras;
  late CameraDescription _firstCamera;

  void initFunction() async {
    // Obtain a list of the available cameras on the device.
    _cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    final _firstCamera = _cameras.first;
  }

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
