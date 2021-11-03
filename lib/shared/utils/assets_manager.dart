import 'dart:convert';

import 'package:flutter/services.dart';

class AssetsManager {
  Future<String> getAsString(String assetName) async {
    String response = await rootBundle.loadString(assetName);
    return response;
  }

  Future<Map<String, dynamic>> getAsMap(String assetName) async {
    String response = await getAsString(assetName);
    Map<String, dynamic> responseData = jsonDecode(response) as Map<String, dynamic>;
    return responseData;
  }
}
