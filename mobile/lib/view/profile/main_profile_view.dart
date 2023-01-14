// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/view/profile/camera/gallery_view.dart';
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
  void _redirectToGallery() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const GalleryView()));
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
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _redirectToGallery,
                icon: Icon(Icons.browse_gallery),
                iconSize: 30,
              ),
              Text(
                'Welcome',
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                onPressed: _redirectToCamera,
                icon: Icon(Icons.camera_alt),
                iconSize: 30,
              ),
            ],
          ),
        ),
        Expanded(
          child: ReceiptListView(),
        )
      ],
    ));
  }
}
