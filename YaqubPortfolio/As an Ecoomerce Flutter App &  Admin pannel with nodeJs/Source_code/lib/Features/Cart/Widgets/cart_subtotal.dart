import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SubTotal extends StatelessWidget {
  const SubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(2.w),
      child: Row(
            children: [
              Text("Subtotal: " , style: TextStyle(fontSize: 15.sp , fontWeight: FontWeight.w500),),
              BlocBuilder<UserCubit, UserInitial>(builder:(context , state){
                final user = BlocProvider.of<UserCubit>(context).state.user;
                int sum = 0;
                user.cart?.map((e) {
                  sum += e['quantity']*e['product']['price'] as int;
                  return sum ;}
                ).toList();
                return Text("\$$sum" , style: TextStyle(fontSize: 15.sp , color: Colors.red));
              })
            ],
      ),
    );
  }
}
