import 'package:clone/Features/Auth/Screens/Auth_Screen.dart';
import 'package:clone/Features/Auth/Services/Auth_services.dart';
import 'package:clone/Features/Home/Screens/HomeScreen.dart';
import 'package:clone/Features/Home/Screens/SplashScreen.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'Constants/colors.dart';
import 'Routes.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child:MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context);
    authServices.getUserData(context: context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: GlobalColors.backgroundColor,
              colorScheme:
                  ColorScheme.light(primary: GlobalColors.secondBackground),
              appBarTheme: AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              )),
          onGenerateRoute: (settings) => generatedRoute(settings),
          home:
          SplashScreen()
      );
      }
    );
  }
}
