import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PresetsProvider with ChangeNotifier {
  int currentID = 0;
  List<dynamic> _presets = [];
  List<dynamic> get presets => _presets;

  PresetsProvider() {
    readJson().then((data) {
      _presets = data;
      notifyListeners();
    });
  }

  Future<List<dynamic>> readJson() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      return [];
    }
  }

  Future<void> writeJson(List<dynamic> presets) async {
    final file = await _localFile;

    await file.writeAsString(jsonEncode(presets));
    _presets = presets;
    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  void savePreset(Map<String, dynamic> preset) {
    _presets.add(preset);
    notifyListeners();
  }

  void deletePreset(int id) {
    _presets.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  void updateJson() {}
}
