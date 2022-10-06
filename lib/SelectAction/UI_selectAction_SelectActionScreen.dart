import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:sosaku/SelectAction/Controller_selectAction_SelectActionController.dart';
import 'package:sosaku/SelectAction/Provider_selectAction_SelectActionScreenProvider.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';
import 'package:table_calendar/table_calendar.dart';


final selectActionScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => SelectActionScreenProvider());

final SelectActionScreenController selectActionScreenController =
    SelectActionScreenController();

class SelectActionScreen extends ConsumerWidget {
    const SelectActionScreen({Key? key}) : super(key: key);

    ///
    /// new ui design
    ///
    @override
    Widget build(BuildContext context, WidgetRef ref) {
        GetScreenSize.setSize(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width
        );
        /// List<Sting> actionList is list of selectable actions.
        /// If other elements(ex. function of selected actions) are contained in this list, change List to Map or List<List> and ListBuilder code too.
        List<String> actionList = ["test1", "test2"];
        SelectActionScreenProvider sasp = ref.watch(selectActionScreenProvider);
        selectActionScreenController.start(sasp, context);
        /*
        final animationProvider = animationController.createProvider('statusUp',
            {'arrow': GetScreenSize.screenHeight() * 0.6, 'opacity': 0}); 
        */
        return Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                    child: SizedBox(
                        width: GetScreenSize.screenWidth(),
                        height: GetScreenSize.screenHeight(),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Expanded(
                                    child: TableCalendar(
                                        firstDay: DateTime.utc(2022, 9, 1), 
                                        lastDay: DateTime.utc(2022, 9, 30),
                                        focusedDay: DateTime.now(), 
                                        shouldFillViewport: true,
                                    ),
                                ),
                                SizedBox(
                                    width: GetScreenSize.screenWidth() * 0.05,
                                ),
                                SizedBox(
                                    width: GetScreenSize.screenWidth() * 0.45,
                                    child: Column(
                                        children: <Widget>[
                                            SizedBox(
                                                height: GetScreenSize.screenHeight() * 0.05,
                                            ),
                                            Expanded(
                                                child: ListView.builder(
                                                    itemCount: actionList.length,
                                                    itemBuilder: (context, index) {
                                                        return Card(
                                                            elevation: 0,
                                                            child: Row(
                                                            children: <Widget>[
                                                                RoundCheckBox(
                                                                    onTap: (selected){
                                                                        // call a function when selected.
                                                
                                                                    }
                                                                ),
                                                                Text(
                                                                    actionList[index],
                                                                    style: const TextStyle(
                                                                        fontSize: 20,
                                                                    ),
                                                                ),
                                                            ],),
                                                        );
                                                    },
                                                ),
                                            ),
                                            SizedBox(
                                                height: GetScreenSize.screenHeight() * 0.1,
                                                child: Stack(
                                                    children: <Widget>[
                                                        // If image of button is created, enable under code to load image.  
                                                        // Image(
                                                        //     image: 
                                                        // ),
                                                        GestureDetector(
                                                            child: const Center(
                                                                child: Text(
                                                                    "OK",
                                                                    style: TextStyle(
                                                                        fontSize: 15,
                                                                    ),    
                                                                ),
                                                            ),    
                                                            onTap: () {
                                                                // call a function to do selected action.

                                                            },                                        
                                                        ),
                                                    ],
                                                ),
                                            ),
                                            SizedBox(
                                                height: GetScreenSize.screenHeight() * 0.05,
                                            ),
                                        ],
                                    ),    
                                ),
                            ],            
                        ),
                    ),
                ),
            ),
        );
    }

  ///
  /// pre ui design
  ///

  /*
  static String _screenImagePath =
      "./assets/drawable/Conversation/004_corridorBB.png";
  static String _characterImagePath =
      "./assets/drawable/CharacterImage/Ayana/normal.png";
  static String _buttonImagePath = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SelectActionScreenProvider sasp = ref.watch(selectActionScreenProvider);
    selectActionScreenController.start(sasp, context);
    final animationProvider = animationController.createProvider('statusUp',
        {'arrow': GetScreenSize.screenHeight() * 0.6, 'opacity': 0});
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
                    onTap: () {
                      selectActionScreenController.selectWork();
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
                    onTap: () {
                      selectActionScreenController.selectNonono();
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
                    onTap: () {
                      selectActionScreenController.selectAyana();
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
                    onTap: () {},
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
                    onTap: () {
                      selectActionScreenController.selectWriting();
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
                    onTap: () {},
                  ),
                ),
                if (ref.watch(selectActionScreenProvider).isStatusUp)
                  Align(
                    alignment: const Alignment(1, 1),
                    child: Container(
                        margin: EdgeInsets.only(
                          bottom: ref
                              .watch(animationProvider)
                              .stateDouble['arrow']!,
                          right: GetScreenSize.screenWidth() * 0.0,
                        ),
                        width: GetScreenSize.screenWidth() * 0.2,
                        height: GetScreenSize.screenWidth() * 0.06,
                        child: Opacity(
                            opacity: ref
                                    .watch(animationProvider)
                                    .stateDouble['opacity'] ??
                                1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BorderedText(
                                  strokeWidth:
                                      GetScreenSize.screenHeight() * 0.01,
                                  strokeColor: Colors.purple,
                                  child: Text(
                                    ref
                                        .watch(selectActionScreenProvider)
                                        .statusUpName,
                                    style: TextStyle(
                                      fontSize:
                                          GetScreenSize.screenWidth() * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (ref
                                        .watch(selectActionScreenProvider)
                                        .statusUpValue >
                                    0)
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.orange,
                                    size: GetScreenSize.screenWidth() * 0.04,
                                  ),
                                if (ref
                                        .watch(selectActionScreenProvider)
                                        .statusUpValue <
                                    0)
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.blue,
                                    size: GetScreenSize.screenWidth() * 0.04,
                                  )
                              ],
                            ))
                        // child: Text(
                        //   '⇧',
                        //   style: TextStyle(
                        //     fontSize: GetScreenSize.screenWidth() * 0.03,
                        //     color: Colors.orange,
                        //   ),
                        // )
                        ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
  */

  /// pre cache image on attention screen.
  static Future<void> prepare(BuildContext context) async {
    ///
    /// new ui design
    ///
    /*
    await precacheImage(AssetImage(_buttonImagePath), context);
    */

    ///
    /// pre ui design
    ///
    /*
    await precacheImage(AssetImage(_screenImagePath), context);
    await precacheImage(AssetImage(_characterImagePath), context);
    */
  }
}
