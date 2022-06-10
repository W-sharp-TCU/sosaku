///package
import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

class LogUI extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();

  LogUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return SizedBox(
      width: GetScreenSize.screenWidth(),
      height: GetScreenSize.screenHeight(),
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GetScreenSize.screenHeight() * 0.01,
              sigmaY: GetScreenSize.screenHeight() * 0.01,
            ),
            child: Container(
              width: GetScreenSize.screenHeight() * 1.5,
              height: GetScreenSize.screenHeight() * 0.95,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 201, 210, 0.5),
                  border: Border.all(
                      color: Colors.white,
                      width: GetScreenSize.screenWidth() * 0.003)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: GetScreenSize.screenHeight() * 1.5,
                    height: GetScreenSize.screenHeight() * 0.1,
                    color: const Color.fromRGBO(255, 201, 210, 0.2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: GetScreenSize.screenHeight() * 0.1,
                          height: GetScreenSize.screenHeight() * 0.1,
                        ),
                        const Spacer(),
                        BorderedText(
                          strokeWidth: GetScreenSize.screenHeight() * 0.005,
                          strokeColor: Colors.pinkAccent,
                          child: Text(
                            "会話ログ",
                            style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.05,
                                color: Colors.white),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            conversationScreenController.openLog();
                          },
                          child: SizedBox(
                            width: GetScreenSize.screenHeight() * 0.1,
                            height: GetScreenSize.screenHeight() * 0.1,
                            child: Center(
                                child: Text(
                              "×",
                              style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.05,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: GetScreenSize.screenHeight() * 1.5,
                      //height: GetScreenSize.screenHeight() * 0.837,
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: GetScreenSize.screenHeight() * 1.5,
                              height: GetScreenSize.screenHeight() * 0.837,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                controller: _scrollController,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (var _i = 0;
                                        _i <
                                            ref
                                                .watch(conversationLogProvider)
                                                .texts
                                                .length;
                                        _i++)
                                      Container(
                                        width:
                                            GetScreenSize.screenHeight() * 1.45,
                                        height:
                                            GetScreenSize.screenHeight() * 0.28,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.white,
                                              width:
                                                  GetScreenSize.screenWidth() *
                                                      0.001,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: GetScreenSize
                                                        .screenHeight() *
                                                    0.2,
                                                height: GetScreenSize
                                                        .screenHeight() *
                                                    0.28,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: GetScreenSize
                                                              .screenHeight() *
                                                          0.1,
                                                      height: GetScreenSize
                                                              .screenHeight() *
                                                          0.1,
                                                      color: Colors.white,
                                                      margin: EdgeInsets.only(
                                                          top: GetScreenSize
                                                                  .screenHeight() *
                                                              0.01),
                                                      child: Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(ref
                                                            .watch(
                                                                conversationLogProvider)
                                                            .iconPaths[_i]),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        conversationScreenController
                                                            .playLogVoice(_i);
                                                      },
                                                      child: SizedBox(
                                                        width: GetScreenSize
                                                                .screenHeight() *
                                                            0.1,
                                                        height: GetScreenSize
                                                                .screenHeight() *
                                                            0.1,
                                                        child: Icon(
                                                          Icons.volume_up,
                                                          color: Colors.white,
                                                          size: GetScreenSize
                                                                  .screenWidth() *
                                                              0.04,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                )),
                                            SizedBox(
                                              width:
                                                  GetScreenSize.screenHeight() *
                                                      1.2,
                                              height:
                                                  GetScreenSize.screenHeight() *
                                                      0.28,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: GetScreenSize
                                                            .screenHeight() *
                                                        1.2,
                                                    height: GetScreenSize
                                                            .screenHeight() *
                                                        0.06,
                                                    child: Align(
                                                      alignment:
                                                          const Alignment(
                                                              -1, 0),
                                                      child: BorderedText(
                                                        strokeWidth: GetScreenSize
                                                                .screenHeight() *
                                                            0.003,
                                                        strokeColor:
                                                            Colors.pinkAccent,
                                                        child: Text(
                                                          ref
                                                              .watch(
                                                                  conversationLogProvider)
                                                              .names[_i],
                                                          style: TextStyle(
                                                            fontSize: GetScreenSize
                                                                    .screenHeight() *
                                                                0.038,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        // TODO : ログジャンプのテスト
                                                        // conversationScreenController
                                                        //     .goLogScene(_i);
                                                      },
                                                      child: Container(
                                                        width: GetScreenSize
                                                                .screenHeight() *
                                                            1.2,
                                                        height: GetScreenSize
                                                                .screenHeight() *
                                                            0.21,
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: GetScreenSize
                                                                  .screenWidth() *
                                                              0.015,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              const Alignment(
                                                                  -1, -1),
                                                          child: BorderedText(
                                                            strokeWidth:
                                                                GetScreenSize
                                                                        .screenHeight() *
                                                                    0.002,
                                                            strokeColor: Colors
                                                                .pinkAccent,
                                                            child: Text(
                                                              ref
                                                                  .watch(
                                                                      conversationLogProvider)
                                                                  .texts[_i],
                                                              style: TextStyle(
                                                                fontSize:
                                                                    GetScreenSize
                                                                            .screenHeight() *
                                                                        0.0307,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: const Alignment(1, 1),
                              child: GestureDetector(
                                onTap: () {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                },
                                child: SizedBox(
                                    width: GetScreenSize.screenHeight() * 0.1,
                                    height: GetScreenSize.screenHeight() * 0.1,
                                    child: Icon(
                                      Icons.arrow_downward_outlined,
                                      size: GetScreenSize.screenHeight() * 0.1,
                                      color: Colors.white,
                                    )),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
