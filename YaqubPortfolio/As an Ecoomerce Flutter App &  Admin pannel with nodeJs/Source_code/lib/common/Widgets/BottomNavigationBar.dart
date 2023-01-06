import 'package:badges/badges.dart';
import 'package:clone/Constants/colors.dart';
import 'package:clone/Features/Account/Screens/AccountScreen.dart';
import 'package:clone/Features/Cart/Screens/cart_screen.dart';
import 'package:clone/Features/Home/Screens/HomeScreen.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const String name = "/actual-Home";

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  double width = 42;
  double bottomBarWidth = 5;

  void updatePage(int page) {
    setState(() {
      index = page;
    });
  }

  List<Widget> Pages = [
    HomeScreen(),
    AccountScreen(),
    CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: GlobalColors.selectedNavBarColors,
        unselectedItemColor: Colors.black,
        backgroundColor: GlobalColors.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          ///Home
          BottomNavigationBarItem(
              icon: Container(
                  width: width,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: index == 0
                                  ? GlobalColors.selectedNavBarColors ??
                                      Colors.cyan
                                  : GlobalColors.backgroundColor,
                              width: bottomBarWidth))),
                  child: Icon(Icons.home_outlined)),
              label: ""),

          ///profile:
          BottomNavigationBarItem(
              icon: Container(
                  width: width,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: index == 1
                                  ? GlobalColors.selectedNavBarColors ??
                                      Colors.cyan
                                  : GlobalColors.backgroundColor,
                              width: bottomBarWidth))),
                  child: Icon(Icons.person_outline)),
              label: ""),

          ///Cart:
          BottomNavigationBarItem(
              icon: Container(
                  width: width,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: index == 2
                                  ? GlobalColors.selectedNavBarColors ??
                                      Colors.cyan
                                  : GlobalColors.backgroundColor,
                              width: bottomBarWidth))),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Badge(
                          elevation: 0,
                          badgeContent: Text("${BlocProvider.of<UserCubit>(context).state.user.cart!.length}",
                              style: TextStyle(color: Colors.white)),
                          badgeColor: Colors.red,
                          child: Icon(Icons.shopping_cart_outlined));
                    },
                  )),
              label: ""),
        ],
      ),
    );
  }
}
