import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_title_TitleScreenProvider.dart';

class TitleScreen extends StatelessWidget{
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    GetScreenSize.setSize
      (MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    var slideshow = context.watch<TitleScreenProvider>();
    slideshow.start(context);

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: GestureDetector(
                onTap: (){
                  slideshow.stop();
                  /*
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ()),
                  );
                  */
                  print("tap");//デバッグ用
                },
                child: Container(
                    height: GetScreenSize.screenHeight(),
                    width: GetScreenSize.screenWidth(),
                    color: Colors.black,
                    child: Stack(
                      children: [

                        Image(
                          fit: BoxFit.cover,
                          image:AssetImage(context.watch<TitleScreenProvider>().mBGImagePath),
                        ),

                        Align(
                          alignment: const Alignment(0, 0.8),
                            child: Text(
                              'Tap to Start',
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                      ],
                    )
                ),
              ),
            )
        )
    );
  }
}