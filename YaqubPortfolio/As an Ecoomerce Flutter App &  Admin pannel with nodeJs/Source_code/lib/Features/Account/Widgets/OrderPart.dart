import 'package:clone/Features/Account/Widgets/SingleProduct.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderPart extends StatelessWidget {
  const OrderPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontSizee = 13.sp;
    List items = [
      "https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Produktfotos_Apple_iPad_2021_1467.jpg",
      "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "https://images.macrumors.com/t/Jzr8kExNit0Q5AH1zt84vwG0KMU=/1600x900/smart/article-new/2019/02/MR-Future-Products-2020-2.png",
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your Orders" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , fontSize: fontSizee),),
              TextButton(onPressed: (){}, child: Text("See all" , style: TextStyle(color: Colors.blueAccent , fontSize: fontSizee),)),
            ],
          ),
        ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        height: 20.h,
        child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: items.length , itemBuilder: (context , index){
              return SingleProduct(image: items[index]);
            }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 3.w,);
        },),
      ),
      ],
    );
  }
}
