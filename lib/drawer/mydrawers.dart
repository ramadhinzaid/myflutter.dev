import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  bool endDrawerEvent = false;
  double dragPosition = 0;
  double dragStart = 0;
  String dragDirection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      // endDrawer: Container(
      //   width: 170,
      //   child: Drawer(
      //     child: DrawerHeader(child: Text("Hai")),
      //   ),
      // ),
      // drawerScrimColor: Colors.transparent,
      // onEndDrawerChanged: (endDrawerState) => setState(() {
      //   endDrawerEvent = endDrawerState;
      // }),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Container(
                width: 195,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              right: endDrawerEvent ? 170 : 0,
              curve: Curves.easeInOut,
              child: GestureDetector(
                // onHorizontalDragStart: (detail) =>
                //     print({detail.localPosition, "Drag Start"}),
                // onHorizontalDragUpdate: (detail) =>
                //     print({detail.localPosition, "Drag Update"}),
                onPanDown: (details) {
                  setState(() {
                    dragPosition = details.localPosition.dx;
                    dragStart = details.localPosition.dx;
                  });
                },
                onPanEnd: (details) {
                  if (dragStart - dragPosition < 35) {
                    setState(() {
                      endDrawerEvent = false;
                    });
                  } else {
                    setState(() {
                      endDrawerEvent = false;
                    });
                  }
                },
                onPanUpdate: (details) {
                  // print("details.localPosition.dx");
                  // if (dragPosition >= MediaQuery.of(context).size.width - 70 &&
                  //     dragPosition > details.localPosition.dx) {
                  //   print("Boleh Scroll");
                  //   setState(() {
                  //     endDrawerEvent = true;
                  //     dragDirection = "Open";
                  //   });
                  //   print(details.localPosition.dx);
                  // } else if (dragPosition < details.localPosition.dx) {
                  //   print("Belum Scroll");
                  //   setState(() {
                  //     endDrawerEvent = false;
                  //     // dragDirection = "Close";
                  //   });
                  // }
                  // setState(() {
                  //   dragPosition = details.localPosition.dx;
                  // });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dismissible(key: Key("H"), child: Text("")),
                      Text("Halo"),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              endDrawerEvent = !endDrawerEvent;
                              // dragDirection =
                              //     dragDirection == "Open" ? "Close" : "Open";
                            });
                            // keyScaffold.currentState.openEndDrawer();
                          },
                          icon: Icon(endDrawerEvent ? Icons.close : Icons.menu))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
