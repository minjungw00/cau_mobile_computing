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
              shape: const ContinuousRectangleBorder(),
              child: SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        preset['name'],
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Focus Time : ${preset['focusTime']}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Break Time : ${preset['breakTime']}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Do Not Disturb : ${preset['doNotDisturb'] ? 'ON' : 'OFF'}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Focus Time : ${preset['getGuide'] ? 'ON' : 'OFF'}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(190, 40)),
                    shape: MaterialStateProperty.all(
                        const ContinuousRectangleBorder()),
                  ),
                  onPressed: () {
                    _presetsProvider.deletePreset(preset);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(190, 40)),
                    shape: MaterialStateProperty.all(
                        const ContinuousRectangleBorder()),
                  ),
                  onPressed: () {
                    _presetsProvider.setCurrent(preset);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
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
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text(
          'Presets',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: ListView(
        children: presetList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text(
          'Add New',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
          ),
        ),
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
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text(
          'Add New Preset',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 200.0, 0.0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textController,
                    ),
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Focus Time",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ),
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Break Time",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ),
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Enable Do Not Disturb",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ),
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Enable Stretching Guide",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                  ),
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
        label: const Text(
          'Add Preset',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
          ),
        ),
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
