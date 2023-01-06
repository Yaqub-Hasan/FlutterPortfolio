import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/colors.dart';
import 'PostsScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const String name = "AdminScreen";
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  int index = 0;
  double width = 42;
  double bottomBarWidth = 5;

  void updatePage(int page){
    setState(() {
      index = page;
    });
  }

  List<Widget> Pages  = [
    PostsScreen(),
    Center(child: Text("2"),),
    Center(child: Text("3"),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: GlobalColors.appBarGradient
              ),
            ),
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset("assets/amazon_in.png" , width:  30.w , height: 10.h, color: Colors.black,),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Admin" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                )
              ],
            ),
          ),
        ),
      body: Pages[index],
        bottomNavigationBar: BottomNavigationBar(currentIndex: index , selectedItemColor: GlobalColors.selectedNavBarColors , unselectedItemColor: Colors.black ,
          backgroundColor: GlobalColors.backgroundColor, iconSize: 28,
          onTap: updatePage,
          items: [
            ///Posts
            BottomNavigationBarItem(icon: Container(
                width: width,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(
                        color: index == 0 ? GlobalColors.selectedNavBarColors ?? Colors.cyan : GlobalColors.backgroundColor,
                        width: bottomBarWidth
                    ))
                ),
                child: Icon(Icons.home_outlined)) , label: ""),
            ///analytics:
            BottomNavigationBarItem(icon: Container(
                width: width,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(
                        color: index == 1 ? GlobalColors.selectedNavBarColors ?? Colors.cyan : GlobalColors.backgroundColor,
                        width: bottomBarWidth
                    ))
                ),
                child: Icon(Icons.analytics_outlined)) , label: ""),
            ///Orders:
            BottomNavigationBarItem(icon: Container(
                width: width,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(
                        color: index == 2 ? GlobalColors.selectedNavBarColors ?? Colors.cyan : GlobalColors.backgroundColor,
                        width: bottomBarWidth
                    ))
                ),
                child: Icon(Icons.all_inbox_outlined)) , label: ""),

          ]),
    );
  }
}
