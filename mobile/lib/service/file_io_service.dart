import 'dart:io';

import 'package:path_provider/path_provider.dart';

// Contains methods to save/read files
class FileIO {
  static final Future<Directory> _localDirectory =
      getApplicationDocumentsDirectory();

  static Future<String> localPath(String path) async {
    return '${(await _localDirectory)!.path}/$path';
  }

  static Future<File> localFile(String path) async {
    return File(await localPath(path));
  }

  static Future<Directory> localSubDirectory(String path) async {
    return Directory(await localPath(path));
  }

  static Future<List<FileSystemEntity>> localFilesList(String path) async {
    return (await localSubDirectory(path))
        .list()
        .where((element) => element is File)
        .toList();
  }

  // Future<File> writeCounter(int counter) async {
  //   final file = await _localFile;

  //   // Write the file
  //   return file.writeAsString('$counter');
  // }
}
