import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    splashMover();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/splash.jpg" , fit: BoxFit.fill),
      ),
    );
  }

  void splashMover() async {
    await Future.delayed(Duration(milliseconds: 1500));
    //Navigator.push(context, MaterialPageRoute(builder: (_) => Screen() ));
  }
}
