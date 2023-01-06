import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oswah_test/Presentation/Screens/MessagesScreen.dart';
import 'package:oswah_test/Presentation/Screens/FindPartnerScreen.dart';
import '../../API/PostData/InsertFireBasetoken.dart';
import 'HomeScreen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {

  DateTime timeBackPressed = DateTime.now();
  int currentIndex = 0;

  getFireToken()async{
    InsertFireBaseToken insertFireBaseToken = InsertFireBaseToken();
    await insertFireBaseToken.getFireBaseToken();
    await insertFireBaseToken.insertToken();
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    getFireToken();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      //Press Again to Exit Functionality:
      onWillPop: () async {

        final differance = DateTime.now().difference(timeBackPressed);
       final isExitWarning = differance >= Duration(seconds: 2);

       timeBackPressed = DateTime.now();

       if(isExitWarning){
         final message = "Press Again To Exit";
         Fluttertoast.showToast(msg: message , fontSize: 15 , backgroundColor: Colors.grey , textColor: Colors.white ,);
         return false;
       }
       else{
         Fluttertoast.cancel();
         return true;
       }
      },
      child: Scaffold(
        body: Stack(children: [
          currentIndex == 0 ? HomeScreen() : Container(),
          currentIndex == 1 ? FindPartnerScreen() : Container(),
          currentIndex == 2 ? MessagesScreen() : Container(),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 80,
                child: Stack(
                    //overflow: Overflow.visible,
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomPainter(),
                      ),
                      Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                            backgroundColor: currentIndex == 1 ? Colors.orange : Colors.black,
                            child: Icon(Icons.search_outlined , size: 40),
                            elevation: 0.1,
                            onPressed: () {
                                   setBottomBarIndex(1);
                                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> FindPartnerScreen()));
                            }),
                      ),
                      Container(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.home,
                                    size: 40,
                                    color: currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    setBottomBarIndex(0);
                                  },
                                  splashColor: Colors.white,
                                ),
                                Text("   Home" , style: TextStyle(color: currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
                                    fontSize: 15 , fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Container(
                              width: size.width * 0.20,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.chat,
                                      size: 40,
                                      color: currentIndex == 2 ? Colors.orange : Colors.grey.shade400,
                                    ),
                                    onPressed: () {
                                      setBottomBarIndex(2);
                                    }),
                                Text("Chat" , style: TextStyle(
                                    color: currentIndex == 2 ? Colors.orange : Colors.grey.shade400,
                                    fontSize: 15 , fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ],
                        ),
                      )

                    ]),
              )),
        ]),
      ),
    );
  }
}

//Custom AppBar Painter
class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    //canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
