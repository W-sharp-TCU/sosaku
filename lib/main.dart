import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sosaku/CustomScrollBehavior.dart';
import 'package:sosaku/Settings/Controller_Settings_SettingsController.dart';
import 'package:sosaku/Splash/UI_splash_SplashScreen.dart';
import 'Settings/Controller_Settings_SettingsController.dart';
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
  SettingsController settingsController = SettingsController();
  await settingsController.getBgmVolumeValue();
  await settingsController.getUiVolumeValue();
  await settingsController.getVoiceVolumeValue();
  await settingsController.getTextSpeedValue();
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
      home: const SplashScreen(), // todo: リリース前には SplashScreen() に書き換える
    );
  }
}
