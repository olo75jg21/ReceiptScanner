import 'dart:math';
import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextScanner {
  static Future<void> printImageText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      print('=================================================');
      print('${block.text}');
      print(' ............. ');

      // print(block.toString());
      // final Rect rect = block.boundingBox;
      // final List<Point<int>> cornerPoints = block.cornerPoints;
      // final String text = block.text;
      // final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // print(' - ');

        // Same getters as TextBlock
        // print('> ${line.text}');
        // for (TextElement element in line.elements) {
        //   print('Element ${element.text}');
        // }
      }
    }

    textRecognizer.close();
  }
}
