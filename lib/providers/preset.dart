import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Preset {
  int? id = 0;
  String? name;
  int? focusTime = 50;
  int? breakTime = 10;
  bool? doNotDisturb = true;
  bool? getGuide = true;

  Preset(
      {this.id,
      this.name,
      this.focusTime,
      this.breakTime,
      this.doNotDisturb,
      this.getGuide});

  Preset.origin() {
    id = 0;
    name = "Preset $id";
    focusTime = 50;
    breakTime = 10;
    doNotDisturb = true;
    getGuide = true;
  }

  factory Preset.fromJson(Map<String, dynamic> json) => Preset(
      id: json["id"],
      name: json["name"],
      focusTime: json['focusTime'],
      breakTime: json['breakTime'],
      doNotDisturb: json['doNotDisturb'],
      getGuide: json['getGuide']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'focusTime': focusTime,
        'breakTime': breakTime,
        'doNotDisturb': doNotDisturb,
        'getGuide': getGuide
      };
}

class PresetList with ChangeNotifier {
  final List<Preset>? presets;
  PresetList({this.presets});

  factory PresetList.fromJson(String jsonString) {
    List<dynamic> listFromJson = json.decode(jsonString);
    List<Preset> presets = <Preset>[];

    presets = listFromJson.map((preset) => Preset.fromJson(preset)).toList();
    return PresetList(presets: presets);
  }

  Future<void> getPreset() async {
    final routeFromJsonFile =
        await rootBundle.loadString('assets/json/presets.json');
    List placeList =
        PresetList.fromJson(routeFromJsonFile).presets ?? <Preset>[];
    notifyListeners();
  }
}
