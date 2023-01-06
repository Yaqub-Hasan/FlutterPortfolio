import 'package:clone/Features/Admin/Screens/AddProductsScreen.dart';
import 'package:clone/Features/Admin/Screens/AdminScreen.dart';
import 'package:clone/Features/Address/Screens/address_Screen.dart';
import 'package:clone/Features/Auth/Screens/Auth_Screen.dart';
import 'package:clone/Features/Cart/Screens/cart_screen.dart';
import 'package:clone/Features/Home/Screens/HomeScreen.dart';
import 'package:clone/Features/Home/Screens/SplashScreen.dart';
import 'package:clone/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:clone/Features/Search/Screens/searchScreen.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';

import 'Features/Home/Screens/category_deals_screen.dart';
import 'common/Widgets/BottomNavigationBar.dart';

Route<dynamic> generatedRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case SplashScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> SplashScreen());
      case AuthScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> AuthScreen());
      case BottomBar.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> BottomBar());
      case HomeScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> HomeScreen());
      case AdminScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> AdminScreen());
      case AddProductsScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> AddProductsScreen());
      case AddressScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> AddressScreen());
      case CartScreen.name:
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> CartScreen());
      case CategoryDealsScreen.name:
        var category = routeSettings.arguments as String;
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> CategoryDealsScreen(category: category));
      case SearchScreen.name:
        var searchQuery = routeSettings.arguments as String;
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> SearchScreen(searchQuery: searchQuery,));
      case ProductDetailsScreen.name:
        var product = routeSettings.arguments as Product;
        return MaterialPageRoute(settings: routeSettings , builder: (_)=> ProductDetailsScreen(product: product));
      default:
        return MaterialPageRoute(settings: routeSettings , builder: (_) => Scaffold(
          body: Center(child: Text("No Screen With this name"),),
        ));
    }
}