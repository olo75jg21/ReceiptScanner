import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:mobile/service/file_io_service.dart';
import 'package:path/path.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  static const int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scans gallery'),
      ),
      body: FutureBuilder<List<FileSystemEntity>>(
        future: FileIO.localFilesList('scans'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: axisCount,
              // ),
              shrinkWrap: false,
              physics: const ScrollPhysics(),
              primary: true,
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: axisCount,
              children: snapshot.data!.map((img) {
                File file = File(img.path);
                Image image = Image.file(file);
                // int imageWidth = ImageSizeGetter.getSize(FileInput(file)).width;
                // return (
                // height: 100.0,
                // width: imageWidth.toDouble(),
                // return image;
                return IconButton(
                  icon: Ink.image(image: image.image, fit: BoxFit.cover),
                  // iconSize: 500,
                  onPressed: () {},
                );
                // );
                // return IconButton(
                //   // constraints:
                //   // BoxConstraints.expand(width: 80, height: 80),
                //   padding: EdgeInsets.zero,
                //   // icon: image,
                //   icon: SizedBox(
                //     // width: 5000,
                //     // height: width * width / imageWidth,
                //     child: image,
                //   ),
                //   // iconSize: 300,
                //   onPressed: () {},
                // );
              }).toList(),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
