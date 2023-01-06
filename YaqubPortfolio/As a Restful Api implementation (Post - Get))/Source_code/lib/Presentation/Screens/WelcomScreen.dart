import 'package:flutter/material.dart';
import 'package:oswah_test/Presentation/Screens/StartupScreen.dart';
import 'LogInScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    Splash();
    super.initState();
  }

  Splash() async{
    await Future.delayed(Duration(milliseconds: 2500));
    Navigator.pushReplacement(context, CustomPageRoute(child: StartupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/bg.png" ,),fit: BoxFit.fitHeight,),
          ),
        child: const Center(child:
          Text("Welcome" , style: TextStyle(color: Colors.black , fontSize: 55 , fontWeight: FontWeight.bold),)
          ,),
        ),
    );
  }
}

class CustomPageRoute  extends PageRouteBuilder{

  CustomPageRoute({required this.child}) : super(
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (context , animation , secondaryAnimation) => child
  );
  final Widget child;



  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    animation = CurvedAnimation(parent: animation, curve: Curves.easeInToLinear);
    return ScaleTransition(scale: animation , child: child, alignment: Alignment.center, );

  }

}
