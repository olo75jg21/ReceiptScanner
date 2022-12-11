import 'dart:math';
import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:string_similarity/string_similarity.dart';

class TextScanner {
  static Future<void> printImageText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    // String text = recognizedText.text;
    String header = "";
    bool wasHeader = false;
    bool wasBody = false;
    Map<String, String> lines = {};
    String lastLine = "";
    int lineIndex = 0;
    String footer = "";
    double d = 1;

    TextBlock titleBlock = recognizedText.blocks
        .firstWhere((element) => element.text.contains('PARAGON FISKALNY'));
    recognizedText.blocks
        .sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
    for (TextBlock block in recognizedText.blocks) {
      if (wasBody) {
        footer += block.text;
      } else if (wasHeader) {
        if (block.lines.any((element) =>
                StringSimilarity.compareTwoStrings(
                    element.text, 'Sprzedaz opodatkowana') >
                0.3) ||
            block.text.contains('SPRZEDAZ OPODATKOWANA')) {
          wasBody = true;
          footer += block.text;
          continue;
        }

        if (lineIndex % 2 == 1) {
          lines[lastLine] = block.text;
        }

        lastLine = block.text;
        lineIndex++;
      } else {
        header += block.text;
        if (block.boundingBox.top > titleBlock.boundingBox.top) {
          // print(
          //     '${block.boundingBox.bottom} > ${titleBlock.boundingBox.bottom}');
          wasHeader = true;
        }
      }

      // print(block.boundingBox.toString());
      // print(block.cornerPoints.toString());
      // print('[${block.boundingBox.}]');
      print(' ............. ');
      print('${block.boundingBox}');

      // print(block.toString());
      // final Rect rect = block.boundingBox;
      // final List<Point<int>> cornerPoints = block.cornerPoints;
      // final String text = block.text;
      // final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        print('> ${line.text}');
        // for (TextElement element in line.elements) {
        //   print('Element ${element.text}');
      }
      // }
    }
    print(header);
    print(' ............. ');
    lines.forEach((key, value) {
      print('$key\t----\t$value');
    });
    print(' ............. ');
    print(footer);

    textRecognizer.close();
  }
}
