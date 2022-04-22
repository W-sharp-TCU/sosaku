import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/CustomScrollBehavior.dart';
import 'Title/UI_title_TitleScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight, // 横固定
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "想咲 - ソウサク -",
      scrollBehavior: CustomScrollBehavior(), // support drag scroll.
      home: const TitleScreen(),
    );
  }
}
