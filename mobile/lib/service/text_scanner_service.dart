import 'dart:core';
import 'dart:ffi';
import 'dart:math';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobile/core/constant/app_color.dart';
import 'package:mobile/core/constant/app_text.dart';
import 'package:mobile/product/widget/v1_elevated_button.dart';
import 'package:string_similarity/string_similarity.dart';

class Pair<T1, T2> {
  T1 first;
  T2 second;

  Pair(this.first, this.second);
}

class TextScanner {
  static bool _between(num a, num start, num stop) {
    if (a > start && a < stop) return true;
    return false;
  }

  // static double _linearFunctionValue(num x, Map<String, double> fn) {
  //   return fn['slope']! * x + fn['intercept']!;
  // }

  // static double _topSlope(TextLine line) {
  //   return (line.boundingBox.topLeft.dy - line.boundingBox.topRight.dy) /
  //       (line.boundingBox.topLeft.dx - line.boundingBox.topRight.dx);
  // }

  // static double _yIntercept(TextLine line, double slope) {
  //   return line.boundingBox.topLeft.dy - slope * line.boundingBox.topLeft.dx;
  // }

  static Future<void> printImageText2(BuildContext context, path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    final blocks = recognizedText.blocks;
    final blocksText = blocks.map((e) => e.text).reduce((v, e) => v + e);
    final lines = blocks.map((e) => e.lines).reduce((v, e) => v + e);
    final linesText = lines.map(((e) => e.text)).reduce((v, e) => v + e);

    //print(recognizedText.text);
    final title = lines.firstWhere((element) =>
        StringSimilarity.compareTwoStrings(
          element.text.toUpperCase(),
          'PARAGON FISKALNY',
        ) >
        0.7);
    final footer = lines.firstWhere((element) {
      // print(element.text);
      return StringSimilarity.compareTwoStrings(
              'SPRZEDAZ'
                  .bestMatch(
                    element.text.split(' ')..map((e) => e.toUpperCase()),
                  )
                  .bestMatch
                  .target!
                  .toUpperCase(),
              'SPRZEDAZ') >
          0.5;
    });

    // final Map<TextLine, Map<String, double>> linearFunctions = {};
    // linearFunctions[title] = {
    //   'slope': _topSlope(title),
    //   'intercept': _yIntercept(title, _topSlope(title))
    // };
    // linearFunctions[footer] = {
    //   'slope': _topSlope(footer),
    //   'intercept': _yIntercept(footer, _topSlope(footer))
    // };

    final List<TextLine> body = lines
        .where(
          (element) => _between(
            element.boundingBox.center.dy,
            title.boundingBox.center.dy, footer.boundingBox.center.dy,
            // linearFunctionValue(
            //     element.boundingBox.top, linearFunctions[title]!),
            // linearFunctionValue(
            //     element.boundingBox.top, linearFunctions[footer]!),
          ),
        )
        .toList();
    final double bodyHeight = footer.boundingBox.top - title.boundingBox.bottom;
    final double averageGap = bodyHeight / body.length;

    // ROWS BASED ON NUMBER OF PRICE VALUES IN BODY
    body.sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
    final leftColumn = body
        .where((element) =>
            element.boundingBox.center.dx < title.boundingBox.center.dx)
        .toList();
    final rightColumn = body
        .where((element) =>
            element.boundingBox.center.dx > title.boundingBox.center.dx)
        .toList();

    print('left: ${leftColumn.length}');
    print('right: ${rightColumn.length}');
    // final double firstLineTop = body.first.boundingBox.top;

    // final double lineHeight =
    //     body.first.boundingBox.bottom - body.first.boundingBox.top;

    // final List<List<TextLine>> txtlines = [];
    // double topLine = body.first.boundingBox.center.dy - lineHeight;
    // // print('avg height: $lineHeight, fifty ${0.5 * lineHeight}');
    // body.forEach((element) {
    //   // print(element.boundingBox.center.dy - topLine);
    //   if ((element.boundingBox.center.dy - topLine) < lineHeight * 0.55) {
    //     txtlines.last.add(element);
    //   } else {
    //     txtlines.add([element]);
    //   }
    //   topLine = element.boundingBox.center.dy;
    // });

    // body.where((element) => element.boundingBox.right > title.boundingBox.right)
    // txtlines.forEach((element) {
    // print('line: ');
    // print('line: ');
    // print('line: ');
    //   print('line: ');
    //   element.forEach((e) {
    //     print(e.text);
    //   });
    // });
    // body.fold(initialValue, (previousValue, element) => null)

    // print('-------COLUMNS----------');
    // for (int i = 1; i < min(rightColumn.length, leftColumn.length); i++) {
    //   print('${leftColumn[i].text}         ${rightColumn[i].text}\n');
    // }
    // print('------------------------');

    // double smallestGap = 1000;
    // double largestGap = 0;
    // for (int i = 1; i < body.length; i += 2) {
    //   double gap = body[i].boundingBox.top - body[i - 1].boundingBox.top;
    //   if (gap < smallestGap) {
    //     smallestGap = gap;
    //   } else if (gap > largestGap) {
    //     largestGap = gap;
    //   }
    // }
    // body.forEach((element) {
    //   print(element.text);
    // });
    // final List<String> bodyLines = [];
    // print('avg gap: $averageGap');
    // body.forEach((element) {
    //   if (bodyLines.isNotEmpty &&
    //       ((bodyLines.length + 1) * averageGap) <=
    //           element.boundingBox.top - firstLineTop) {
    //     bodyLines.last += element.text;
    //   } else {
    //     bodyLines.add(element.text);
    //   }
    // });
    // print('BODY LINES:');
    // bodyLines.forEach((element) {
    //   print(element);
    // });
    // print('----------------------');

    // body.forEach((element) {
    //   print(
    //       '${element.text} <${element.boundingBox.left}, ${element.boundingBox.right}> v${element.boundingBox.bottom}');
    // });
    List<Pair<String, String>> pairsList = [];
    // for (int i = 1; i < body.length; i += 2) {
    //   pairsList.addAll({body[i - 1].text: body[i].text});
    // // }
    // pairsList.add(Pair(leftColumn[i].text, rightColumn[j++].text));
    int j = 0; // right column index
    for (int i = 0; i < leftColumn.length; i++) {
      if (leftColumn[i].boundingBox.center.dy <=
          rightColumn[j].boundingBox.top) {
        continue;
      }
      pairsList.add(Pair(leftColumn[i].text, rightColumn[j++].text));
    }
    // for (int i = 0; i < min(leftColumn.length, rightColumn.length); i++) {
    //   pairsList.addAll({leftColumn[i].text: rightColumn[i].text});
    // }
    // final double tolerance = 25;
    // for (int i = 0; i < rightColumn.length; i++) {
    //   pairsList.addAll({leftColumn[i].text: rightColumn[i].text});
    // }
    textRecognizer.close();

    // print('title: ${linearFunctions[title]}');
    // print('footer: ${linearFunctions[footer]}');
    showDialog(
      // barrierColor: Colors.amber,
      context: context,
      builder: (_) {
        var singleChildScrollView = SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Table(
                  defaultColumnWidth: const FixedColumnWidth(140.0),
                  border: TableBorder.all(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  children: <TableRow>[
                    const TableRow(
                      children: [
                        Text('Name', textAlign: TextAlign.center),
                        Text('Price', textAlign: TextAlign.center),
                      ],
                    ),
                    ...pairsList.map(
                      (e) => TableRow(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8)),
                            initialValue: e.first,
                            onSaved: (newValue) {
                              e.first = newValue!;
                            },
                          ),
                          TextFormField(
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8)),
                              initialValue: e.second,
                              onSaved: (newValue) {
                                e.second = newValue!;
                              }),
                        ],
                      ),
                    )
                  ],
                ),
                V1ElevatedButton(
                  borderRadius: 20,
                  color: AppColors.loginColor,

                  onPressed: () => Navigator.pop(context),
                  // ? null
                  // : () {
                  // submitForm();
                  // },
                  child: Text(
                    AppText.save.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
        return AlertDialog(
          contentPadding: const EdgeInsets.all(1),
          backgroundColor: Colors.white70,
          // backgroundColor: Colors.transparent,
          content: singleChildScrollView,
        ).build(context);
      },
    );

    textRecognizer.close();
  }

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
    double tolerance = 5;

    TextBlock titleBlock = recognizedText.blocks
        .firstWhere((element) => element.text.contains('PARAGON FISKALNY'));
    recognizedText.blocks
        .sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
    List<String> connectedBlocks = [];
    TextBlock last = recognizedText.blocks.first;
    for (TextBlock block in recognizedText.blocks) {
      if (connectedBlocks.isNotEmpty &&
          (block.boundingBox.top - last.boundingBox.top).abs() < tolerance) {
        connectedBlocks.last += block.text;
      } else {
        connectedBlocks.add(block.text);
        last = block;
      }

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

    connectedBlocks.forEach((element) {
      print(element);
    });
    textRecognizer.close();
  }
}
