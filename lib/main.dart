import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:sosaku/CustomScrollBehavior.dart';
import 'package:sosaku/Settings/Controller_Settings_SettingsController.dart';
import 'package:sosaku/Splash/UI_splash_SplashScreen.dart';
import 'l10n/l10n.dart';
import 'nonweb_url_strategy.dart'
    if (dart.library.html) 'web_url_strategy.dart';

late PackageInfo packageInfo;
SimpleLogger logger = SimpleLogger();

Future<void> main() async {
  // Restrict device's screen orientation.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive); // Hide Status Bar & Navigation Bar.
  configureUrl();
  packageInfo = await PackageInfo.fromPlatform(); // Get App info (e.g. version)
  SettingsController settingsController = SettingsController();
  await settingsController.getBgmVolumeValue();
  await settingsController.getUiVolumeValue();
  await settingsController.getVoiceVolumeValue();
  await settingsController.getTextSpeedValue();
  logger.setLevel(Level.ALL,
      stackTraceLevel: Level.ALL, includeCallerInfo: true); // for debug
  /*logger.setLevel(Level.INFO,
      stackTraceLevel: Level.SEVERE,
      includeCallerInfo: false); // todo: リリース時にはこちらに書き換える*/
  //runApp(const ProviderScope(child: MyApp()));
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
