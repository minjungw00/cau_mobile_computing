import 'package:cau_mobile_computing/providers/preset.dart';
import 'package:flutter/material.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({Key? key}) : super(key: key);

  @override
  State<PresetPage> createState() => _PresetPage();
}

class _PresetPage extends State<PresetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presets'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Preset'),
        tooltip: 'Add Preset',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPresetPage()),
          );
        },
      ),
    );
  }
}

class AddPresetPage extends StatefulWidget {
  const AddPresetPage({Key? key}) : super(key: key);

  @override
  State<AddPresetPage> createState() => _AddPressPageState();
}

class _AddPressPageState extends State<AddPresetPage> {
  final focusTimeList = [5, 10, 15, 20, 25, 30, 40, 50, 60, 90, 120];
  final breakTimeList = [5, 10, 15, 20, 25, 30];
  Preset preset = Preset.origin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Presets'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text("Focus Time"),
                  DropdownButton(
                    value: preset.focusTime,
                    items: focusTimeList.map((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value.toString()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        preset.focusTime = value;
                      });
                    },
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text("Break Time"),
                  DropdownButton(
                    value: preset.breakTime,
                    items: breakTimeList.map((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value.toString()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        preset.breakTime = value;
                      });
                    },
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text("Enable Do Not Disturb"),
                  Checkbox(
                    value: preset.doNotDisturb,
                    onChanged: (value) {
                      setState(() {
                        preset.doNotDisturb = value;
                      });
                    },
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text("Enable Stretching Guide"),
                  Checkbox(
                    value: preset.getGuide,
                    onChanged: (value) {
                      setState(() {
                        preset.getGuide = value;
                      });
                    },
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
