import 'package:cau_mobile_computing/widgets/stretch_page.dart';
import 'package:cau_mobile_computing/widgets/preset_page.dart';
import 'package:cau_mobile_computing/providers/preset.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PresetsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PresetsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PresetsProvider _presetsProvider;

  @override
  Widget build(BuildContext context) {
    _presetsProvider = Provider.of<PresetsProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 200,
              child: Card(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    if (!_presetsProvider.presets['current']
                        .containsKey('name')) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              content: SizedBox(
                                width: 200,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "You must select preset!",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FocusTimePage()),
                        (route) => false,
                      );
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
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
            ElevatedButton(
              child: Text(
                "${!_presetsProvider.presets['current'].containsKey('name') ? 'No Presets' : _presetsProvider.presets['current']['name']}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PresetPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
