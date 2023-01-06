import 'package:clone/Features/Auth/Screens/Auth_Screen.dart';
import 'package:clone/Features/Home/Screens/HomeScreen.dart';
import 'package:clone/common/Widgets/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../Logic(Cubit)/user_cubit.dart';
import '../../Admin/Screens/AdminScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String name = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context);
    NaviMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Getting Data ready ..... ",
        style: TextStyle(color: Colors.orange, fontSize: 20.sp),
      )),
    );
  }

  void NaviMethod() async {
    await Future.delayed(Duration(seconds: 2));
    BlocProvider.of<UserCubit>(context).state.token.isNotEmpty
        ? BlocProvider.of<UserCubit>(context).state.user.type == "user"
            ? Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.name, (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, AdminScreen.name, (route) => false)
        : Navigator.pushNamedAndRemoveUntil(
            context, AuthScreen.name, (route) => false);
  }
}
