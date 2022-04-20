import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sosaku/Load/Provider_load_LoadScreenProvider.dart';
import 'package:sosaku/Title/Provider_title_TitleScreenProvider.dart';
import 'Title/UI_title_TitleScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight, // 横固定
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TitleScreenProvider()),
        ChangeNotifierProvider(create: (_) => LoadScreenProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "sosaku",
      home: TitleScreen(),
    );
  }
}
