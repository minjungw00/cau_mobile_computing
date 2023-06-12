import 'package:cau_mobile_computing/providers/preset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({Key? key}) : super(key: key);

  @override
  State<PresetPage> createState() => _PresetPage();
}

class _PresetPage extends State<PresetPage> {
  late PresetsProvider _presetsProvider;

  bool showButton = false;

  List<Widget> presetList() {
    List<Widget> childs = [];
    if (_presetsProvider.presets.isEmpty) {
      childs.add(const Center(
        child: Text("No Presets"),
      ));
    } else {
      for (Map<String, dynamic> preset in _presetsProvider.presets['list']) {
        childs.add(Column(
          children: [
            Card(
              child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    showButton = showButton ? false : true;
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(preset['name']),
                      ),
                      Column(
                        children: [
                          Text('Focus Time : ${preset['focusTime']}'),
                          Text('Break Time : ${preset['breakTime']}'),
                          Text(
                              'Do Not Disturb : ${preset['doNotDisturb'] ? 'ON' : 'OFF'}'),
                          Text(
                              'Focus Time : ${preset['getGuide'] ? 'ON' : 'OFF'}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _presetsProvider.deletePreset(preset);
                    },
                    child: const Text('Delete')),
                ElevatedButton(
                    onPressed: () {
                      _presetsProvider.setCurrent(preset);
                      Navigator.pop(context);
                    },
                    child: const Text('Select')),
              ],
            )
          ],
        ));
      }
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presets'),
      ),
      body: ListView(
        children: presetList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add New Preset'),
        tooltip: 'Add New Preset',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPresetPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
  Map<String, dynamic> preset = {
    'id': 0,
    'name': 'Preset',
    'focusTime': 50,
    'breakTime': 10,
    'doNotDisturb': true,
    'getGuide': true
  };
  TextEditingController textController = TextEditingController();
  String text = '';
  late PresetsProvider _presetsProvider;

  void addPreset() {
    if (text == '') text = 'Preset ${_presetsProvider.presets['id']}';
    _presetsProvider.presets['id']++;
    preset['name'] = text;
    _presetsProvider.presets['list'].add(preset);
    _presetsProvider.writeJson(_presetsProvider.presets);
  }

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Preset'),
      ),
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 200.0, 0.0),
                    child: Text("Name"),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textController,
                    ),
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Focus Time"),
                  DropdownButton(
                    value: preset['focusTime'],
                    items: focusTimeList.map((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value.toString()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        preset['focusTime'] = value;
                      });
                    },
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Break Time"),
                  DropdownButton(
                    value: preset['breakTime'],
                    items: breakTimeList.map((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value.toString()));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        preset['breakTime'] = value;
                      });
                    },
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Enable Do Not Disturb"),
                  Checkbox(
                    value: preset['doNotDisturb'],
                    onChanged: (value) {
                      setState(() {
                        preset['doNotDisturb'] = value;
                      });
                    },
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Enable Stretching Guide"),
                  Checkbox(
                    value: preset['getGuide'],
                    onChanged: (value) {
                      setState(() {
                        preset['getGuide'] = value;
                      });
                    },
                  ),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Preset'),
        tooltip: 'Add Preset',
        onPressed: () {
          addPreset();
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
