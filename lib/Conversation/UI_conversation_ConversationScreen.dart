import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

class ConversationScreen extends ConsumerWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            color: Colors.black,
            child: Stack(
              children: [
                /* 背景の画像が上がり次第利用　それまではcontainerで代用
                Image(
                  fit: BoxFit.cover,
                  image:AssetImage(),
                ),
                */

                //背景代用container
                Container(
                  height: GetScreenSize.screenHeight(),
                  width: GetScreenSize.screenWidth(),
                  /*color: Colors.green,*/
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/drawable/Conversation/4k.jpg")),
                  ),
                ),
                Align(
                    alignment: const Alignment(0, 1),
                    child: Container(
                      height: GetScreenSize.screenHeight() * 0.7,
                      width: GetScreenSize.screenWidth() * 0.5,
                      color: Colors.pink, //画像を用意したら消す
                      /*
                    child: Image(
                      fit: BoxFit.cover,
                      image:AssetImage(),
                    )
                    */
                    )),

                Align(
                  alignment: const Alignment(0, 1),
                  child: GestureDetector(
                    onTap: () {
                      print("tap");
                    },
                    child: Container(
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white.withOpacity(0.5), //画像を用意したら消す
                      padding: EdgeInsets.all(
                        GetScreenSize.screenWidth() * 0.005,
                      ),
                      child: Stack(
                        children: [
                          /* ここでImage置くより上のContainerでdecorationしたほうがいいかもね
                          Image(
                            fit: BoxFit.cover,
                            image:AssetImage(),
                          ),
                          */

                          Align(
                            alignment: const Alignment(-1, -1),
                            child: Text(
                              "おためし  apple banana \nテキスト orange\nです\n４行目は表示なし",
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
