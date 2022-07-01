import 'package:flutter/material.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';


class SelectActionScreen extends StatelessWidget {
  const SelectActionScreen({Key? key}) : super(key: key);
  static String _screenImagePath = "./assets/drawable/Conversation/004_corridorBB.png";
  static String _characterImagePath = "./assets/drawable/CharacterImage/Ayana/normal.png";
  static String _buttonImagePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: Container(
            width: GetScreenSize.screenWidth(),
            height: GetScreenSize.screenHeight(),
            child: Stack(
              children: <Widget>[
                Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    _screenImagePath,
                  ),
                ),
                Align(
                  alignment: const Alignment(0.7, 0),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      _characterImagePath,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.85, -0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("バイトに行く"),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.85, 0),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("のののと過ごす"),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.85, 0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("あやなと過ごす"),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.30, -0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("1人で執筆"),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.30, 0),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("授業に行く"),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.30, 0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("川本習に電話"),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// pre cache image on attention screen.
  static Future<void> prepare(BuildContext context) async {
    await precacheImage(AssetImage(_screenImagePath), context);
    await precacheImage(AssetImage(_characterImagePath), context);
  }
}