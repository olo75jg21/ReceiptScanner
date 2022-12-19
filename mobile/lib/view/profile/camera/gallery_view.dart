import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/service/file_io_service.dart';
import 'package:mobile/service/text_scanner_service.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  static const int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginColor,
      appBar: AppBar(
        backgroundColor: AppColors.loginColor,
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
                  iconSize: 500,
                  onPressed: () async {
                    try {
                      await TextScanner.printImageText2(context, img.path);
                    } catch (_) {
                      AnimatedSnackBar.material(
                        AppText.errorOCR,
                        type: AnimatedSnackBarType.error,
                        duration: const Duration(seconds: 4),
                        // mobileSnackBarPosition: MobileSnackBarPosition.top,
                      ).show(context);
                    }
                  },
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
