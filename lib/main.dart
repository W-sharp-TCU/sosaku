import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sosaku/l10n/l10n.dart';
import 'UI_title_TitleScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight, // 横固定
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title:"想咲~sosaku~",
      home: TitleScreen(),
    );
  }
}