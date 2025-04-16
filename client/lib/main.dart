import 'package:craft_everything/screens/craft_screen.dart';
import 'package:flutter/material.dart';

import 'services/unlock_elements_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UnlockedElementService.init();
  runApp(const CraftEverything());
}

class CraftEverything extends StatelessWidget {
  const CraftEverything({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CraftScreen(),
    );
  }
}
