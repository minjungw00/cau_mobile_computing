import 'package:cau_mobile_computing/providers/preset.dart';
import 'package:cau_mobile_computing/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FocusTimePage extends StatefulWidget {
  const FocusTimePage({Key? key}) : super(key: key);

  @override
  State<FocusTimePage> createState() => _FocusTimePageState();
}

class _FocusTimePageState extends State<FocusTimePage> {
  late PresetsProvider _presetsProvider;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PresetsProvider auth =
          Provider.of<PresetsProvider>(context, listen: false);
      auth.startTimer(false);
      _timer =
          Timer(Duration(seconds: auth.presets['current']['focusTime']), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BreakTimePage()),
          (route) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
              "${_presetsProvider.start ~/ 60} : ${(_presetsProvider.start % 60).toInt()}"),
          onPressed: () {
            _presetsProvider.stopTimer();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class BreakTimePage extends StatefulWidget {
  const BreakTimePage({Key? key}) : super(key: key);

  @override
  State<BreakTimePage> createState() => _BreakTimePageState();
}

class _BreakTimePageState extends State<BreakTimePage> {
  late PresetsProvider _presetsProvider;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PresetsProvider auth =
          Provider.of<PresetsProvider>(context, listen: false);
      auth.startTimer(true);
      _timer =
          Timer(Duration(seconds: auth.presets['current']['breakTime']), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const FocusTimePage()),
          (route) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
              "${_presetsProvider.start ~/ 60} : ${(_presetsProvider.start % 60).toInt()}"),
          onPressed: () {
            _presetsProvider.stopTimer();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
