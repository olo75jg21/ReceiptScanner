import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/view/profile/receipt_list_view.dart';
import 'package:mobile/view/profile/camera/camera_view.dart';

// import '../test_view.dart';

class MainProfileView extends StatefulWidget {
  const MainProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfileView> {
  void _redirectToReceiptList() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ReceiptListView()));
  }

  Future<void> _redirectToCamera() async {
    await availableCameras().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CameraView(cameras: value),
          ),
        ));
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
              child: const Text('Receipts'),
            ),
            TextButton(
              onPressed: _redirectToCamera,
              child: const Text('Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
