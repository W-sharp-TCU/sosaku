import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sosaku/CustomScrollBehavior.dart';
import 'package:sosaku/Settings/Controller_Settings_SettingsController.dart';
import 'Settings/Controller_Settings_SettingsController.dart';
import 'Title/UI_title_TitleScreen.dart';
import 'Wrapper/wrapper_SoundPlayer.dart';
import 'l10n/l10n.dart';

late PackageInfo packageInfo;

Future<void> main() async {
  // restrict device screen orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive); // hide Android status bar & navigation bar.
  packageInfo = await PackageInfo.fromPlatform();
  SoundPlayer.init();
  await TitleScreen.prepare();
  SettingsController settingsController = SettingsController();
  settingsController.getBgmVolumeValue();
  settingsController.getUiVolumeValue();
  settingsController.getVoiceVolumeValue();
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
      theme: ThemeData(fontFamily: "SourceHanSansJP"),
      scrollBehavior:
          CustomScrollBehavior(), // support dragging mouse to scroll on the web.
      home: TitleScreen(),
    );
  }
}
