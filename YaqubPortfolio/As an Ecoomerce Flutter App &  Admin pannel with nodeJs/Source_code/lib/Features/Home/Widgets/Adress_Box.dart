import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<UserCubit>(context).state.user;
    return Container(
      height: 5.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 114, 216, 221),
          Color.fromARGB(255, 162, 236, 233),
        ],
        stops: [0.5 , 1.0]
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.location_on_outlined , size: 15.sp,),
            Expanded(child: Text("  Delivery to ${user.name}  - ${user.address}" ,style: TextStyle(
              fontWeight: FontWeight.w500 , overflow: TextOverflow.ellipsis
            ),)),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}
