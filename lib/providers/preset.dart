import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cau_mobile_computing/widgets/stretch_page.dart';

class PresetsProvider with ChangeNotifier {
  Map<String, dynamic> _presets = {};
  Map<String, dynamic> get presets => _presets;
  late Timer _timer;
  int _start = 0;
  int get start => _start;

  PresetsProvider() {
    readJson().then((data) {
      _presets = data;
    });

    if (_presets.isEmpty) {
      Map<String, dynamic> current = {};
      List<Map<String, dynamic>> list = [];

      _presets = {'current': current, 'id': 0, 'list': list};
    }

    notifyListeners();
  }

  Future<Map<String, dynamic>> readJson() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      Map<String, dynamic> current = {};
      List<Map<String, dynamic>> list = [];

      return {'current': current, 'id': 0, 'list': list};
    }
  }

  Future<void> writeJson(Map<String, dynamic> presets) async {
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
    _presets['list'].add(preset);
    writeJson(_presets);
    notifyListeners();
  }

  void deletePreset(Map<String, dynamic> preset) {
    if (_presets['current']['name'] == preset['name'] &&
        _presets['current']['focusTime'] == preset['focusTime'] &&
        _presets['current']['breakTime'] == preset['breakTime'] &&
        _presets['current']['doNotDisturb'] == preset['doNotDisturb'] &&
        _presets['current']['getGuide'] == preset['getGuide']) {
      _presets['current'] = {};
    }
    _presets['list'].remove(preset);
    writeJson(_presets);
    notifyListeners();
  }

  void setCurrent(Map<String, dynamic> preset) {
    _presets['current'] = preset;
    writeJson(_presets);
    notifyListeners();
  }

  void startTimer(bool isBreak, BuildContext context) {
    _start = _presets['current'][isBreak ? 'breakTime' : 'focusTime'] * 60;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_start < 1) {
          timer.cancel();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isBreak ? const FocusTimePage() : const BreakTimePage()),
            (route) => false,
          );
        } else {
          _start = _start - 1;
        }
        notifyListeners();
      },
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
