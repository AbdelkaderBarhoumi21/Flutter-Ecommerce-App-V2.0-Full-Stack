import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelperFunctions {
  AppHelperFunctions._();

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon';
    } else if (hour >= 16 && hour < 19) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  //function to convert asset to file
  static Future<File> assetToFile(String assetPath) async {
    //load asset bytes
    final byteData = await rootBundle.load(assetPath);
    //get temp directory
    final tempDir = await getTemporaryDirectory();//return a temp dir for this app (eg /data/user/0/com.example.app/cache)
    final file = File('${tempDir.path}/${assetPath.split('/').last}');///data/user/0/com.example.app/cache/logo.png
    //write bytes to temp file
    await file.writeAsBytes(byteData.buffer.asUint8List());//write the byte to the file logo.png
    return file;
  }
}
