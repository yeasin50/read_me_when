import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/quranic_verse.dart';

Future<List<QuranicVerse>> loadVerseFromFile(String fileName) async {
  String jsonString = await rootBundle.loadString('assets/$fileName.json');

  List<dynamic> jsonList = jsonDecode(jsonString);

  return jsonList.map((json) => QuranicVerse.fromMap(json)).toList();
}
