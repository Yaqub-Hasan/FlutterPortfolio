import 'package:die_praxis_manegement/Presentation/Screens/AddOrEditPatient.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'Presentation/Screens/HomeScreen.dart';

void main() {
  runApp(
      Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            theme: ThemeData(
              fontFamily: 'amiri'
            ),
            home:
            HomeScreen()
          //AddOrEditPatient()
        );
      }
  ));
}


