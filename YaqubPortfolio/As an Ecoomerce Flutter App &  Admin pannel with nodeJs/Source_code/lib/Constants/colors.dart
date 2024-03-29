import 'dart:ui';
import 'package:flutter/material.dart';

String url = "http://192.168.1.14:3000";

class GlobalColors{

  static const appBarGradient = LinearGradient(colors:[
       Color.fromARGB(255, 29, 201, 192),
       Color.fromARGB(255, 125, 221, 216),
      ],
  stops: [0.5 , 1.0]
  );

  static Color secondBackground = Color.fromRGBO(255, 153, 0, 1);
  static Color greyBackgroundColor = Color(0xffebecee);
  static Color backgroundColor = Colors.white;
  static Color? selectedNavBarColors = Colors.cyan[800];



  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/fashion.jpeg',
    },
  ];

}


