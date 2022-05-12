import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/CustomScrollBehavior.dart';
import 'Title/UI_title_TitleScreen.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  // restrict device screen orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);
  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.immersive); // hide Android status bar & navigation bar.
  // await TitleScreen.prepare();
  // runApp(const ProviderScope(child: MyApp()));
  print("Hello World");
  int i = 0;
  Got got = Got();
  while (i < 10) {
    got.num(i);
    i++;
  }
  Aironman aironman1 = Aironman(1, 2);
  Aironman aironman2 = Aironman(100, 1);
  AdvancedAiroman aironman3 = AdvancedAiroman(1, 4, 400);
  aironman2.kick();
  aironman1.panti();
  aironman3.beam();
  aironman3.kick();
}

class Aironman {
  late int massuru;
  late int color; //インスタンス変数（クラス内だと呼び出し可能）
  Aironman(int m, int c) {
    int massuru;
    this.massuru = m;
    this.color = c;
  }
  void panti() {
    print("筋肉量$massuru、色$color,パンチしました。");
  }

  void kick() {
    print("筋肉量$massuru,色$color,キックしました。");
  }
}

class AdvancedAiroman extends Aironman {
  late int siryoku;
  AdvancedAiroman(int m, int c, int s) : super(m, c) {
    this.siryoku = s;
  }

  void beam() {
    print("筋力量${super.massuru},色${super.color},視力${this.siryoku},ビームしました。");
  }

  //@Override
  void kick() {
    super.kick();
    print("回し蹴りしました。");
  }
}

class Got {
  void num(int g) {
    if (g % 2 == 0) {
      print("${g - 1}は偶数です.");
    } else {
      print((g - 1).toString() + "は奇数です。");
    }
  }
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
