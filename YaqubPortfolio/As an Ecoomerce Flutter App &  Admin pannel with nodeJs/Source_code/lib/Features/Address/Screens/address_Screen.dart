import 'package:clone/Constants/colors.dart';
import 'package:clone/Logic(Cubit)/user_cubit.dart';
import 'package:clone/common/Widgets/customButton.dart';
import 'package:clone/common/Widgets/formField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);
  static const String name = "AddressScreen";

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController flatHouseController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pineCodeController = TextEditingController();
  TextEditingController townCityController = TextEditingController();

  String? address;
  List<PaymentItem> paymentItemList = [];

  void onApplePayResult(res){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(8.h),
            child: AppBar(
              flexibleSpace: Container(
                decoration:
                    BoxDecoration(gradient: GlobalColors.appBarGradient),
              ),
            )),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:2.w, vertical: 3.w ),
        child: Column(
          children: [
              BlocBuilder<UserCubit , UserInitial>(
                builder: (context , state){
                  address = BlocProvider.of<UserCubit>(context).state.user.address;
                  return address!.isNotEmpty ? Column(
                    children: [
                       Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 13.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1 , color: Colors.black),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(address! , style: TextStyle(color: Colors.black),),
                      ),
                      SizedBox(height: 3.w,),
                      Text("-OR-" , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 14.sp),),
                      // SizedBox(height: 3.w,),
                    ],
                  ) : Container();
                },
              ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  customFormField(controller: flatHouseController, hintText: "Flat / House no , Building ", textInputType: TextInputType.text),
                  customFormField(controller: areaController, hintText: "Area, Street", textInputType: TextInputType.text),
                  customFormField(controller: pineCodeController, hintText: "Pine Code", textInputType: TextInputType.text),
                  customFormField(controller: townCityController, hintText: "Town / City ", textInputType: TextInputType.text),
                   CustomButton(label: "Buy with Google pay", ButtonWidth: double.infinity ,onPressed: (){
                    if(_formKey.currentState!.validate()){

                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
