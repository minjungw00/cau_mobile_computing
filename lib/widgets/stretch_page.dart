import 'package:cau_mobile_computing/providers/preset.dart';
import 'package:cau_mobile_computing/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FocusTimePage extends StatefulWidget {
  const FocusTimePage({Key? key}) : super(key: key);

  @override
  State<FocusTimePage> createState() => _FocusTimePageState();
}

class _FocusTimePageState extends State<FocusTimePage> {
  late PresetsProvider _presetsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PresetsProvider auth =
          Provider.of<PresetsProvider>(context, listen: false);
      auth.startTimer(false, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Focus Time",
              style: TextStyle(
                fontSize: 50,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    _presetsProvider.stopTimer();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false,
                    );
                  },
                  child: Center(
                    child: Text(
                      "${_presetsProvider.start ~/ 60 < 10 ? '0' : ''}${_presetsProvider.start ~/ 60}:${_presetsProvider.start % 60 < 10 ? '0' : ''}${(_presetsProvider.start % 60).toInt()}",
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Click Timer to Stop Routine",
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakTimePage extends StatefulWidget {
  const BreakTimePage({Key? key}) : super(key: key);

  @override
  State<BreakTimePage> createState() => _BreakTimePageState();
}

class _BreakTimePageState extends State<BreakTimePage> {
  late PresetsProvider _presetsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PresetsProvider auth =
          Provider.of<PresetsProvider>(context, listen: false);
      auth.startTimer(true, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Break Time",
              style: TextStyle(
                fontSize: 30,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: Card(
                shape: const StadiumBorder(),
                child: InkWell(
                  onTap: () {
                    _presetsProvider.stopTimer();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false,
                    );
                  },
                  child: Center(
                    child: Text(
                      "${_presetsProvider.start ~/ 60 < 10 ? '0' : ''}${_presetsProvider.start ~/ 60}:${_presetsProvider.start % 60 < 10 ? '0' : ''}${(_presetsProvider.start % 60).toInt()}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Click Timer to Stop Routine",
              style: TextStyle(
                fontSize: 10,
                color: Colors.deepPurple,
              ),
            ),
            if (_presetsProvider.presets['current']['getGuide'])
              const SizedBox(
                height: 20,
              ),
            if (_presetsProvider.presets['current']['getGuide'])
              SizedBox(
                width: 400,
                height: 600,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Image(
                          image: AssetImage(
                              'assets/images/stretching_exercises.png'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          '''1. Raise one hand up and stretch to the other.
2. Repeat 5 sets of 30 seconds each.
3. After the set, stretch the other side in the same way.''',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
