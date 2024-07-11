import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*class FileHelper {
  static Future<dynamic> loadJsonFromAssets({
    required BuildContext context,
    required String path,
  }) async {
    return jsonDecode(
      await DefaultAssetBundle.of(context).loadString('assets/$path'),
    );
  }
}*/

class FileHelper {
  static Future<dynamic> loadJsonFromAssets({required String path}) async {
    String jsonString = await rootBundle.loadString('assets/$path');
    return jsonDecode(jsonString);
  }
}