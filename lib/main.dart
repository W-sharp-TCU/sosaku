import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/CustomScrollBehavior.dart';
import 'Title/UI_title_TitleScreen.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  // restrict device screen orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive); // hide Android status bar & navigation bar.
  await TitleScreen.prepare();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "想咲 - ソウサク -",
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      scrollBehavior:
          CustomScrollBehavior(), // support dragging mouse to scroll on the web.
      home: TitleScreen(),
    );
  }
}
