import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clone/Constants/errorMessages.dart';
import 'package:clone/Features/Admin/Server/admin_services.dart';
import 'package:clone/common/Widgets/customButton.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/colors.dart';
import '../../../common/Widgets/formField.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);
  static const String name = "addProductsScreen";

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {

  AdminServices adminServices = AdminServices();

  ///Controllers:
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  final addProduct = GlobalKey<FormState>();
  String categoryValue = 'Mobiles';

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  List<File> images = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() async {
    if(addProduct.currentState!.validate() && images.isNotEmpty){
      adminServices.sellProduct(context: context, name: productNameController.text, description: descriptionController.text,
          price: double.parse(priceController.text), quantity: double.parse(quantityController.text), category: categoryValue, images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: GlobalColors.appBarGradient),
            ),
            title: Text(
              "Add a new Product",
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addProduct,
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              children: [
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((e) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              e,
                              fit: BoxFit.fill,
                            ),
                          );
                        }).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 25.h))
                    : InkWell(
                        onTap: selectImages,
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(18),
                            dashPattern: [10, 4],
                            child: Container(
                              width: double.infinity, height: 20.h,
                              //alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    color: Colors.black54,
                                    size: 60.sp,
                                  ),
                                  Text(
                                    "Select product images",
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                            )),
                      ),
                SizedBox(
                  height: 2.w,
                ),
                customFormField(
                    controller: productNameController,
                    hintText: "Product Name",
                    textInputType: TextInputType.name),
                customFormField(
                  controller: descriptionController,
                  hintText: "Product description",
                  textInputType: TextInputType.name,
                  maxLines: 7,
                ),
                customFormField(
                    controller: priceController,
                    hintText: "Product price",
                    textInputType: TextInputType.number),
                customFormField(
                    controller: quantityController,
                    hintText: "Product quantity",
                    textInputType: TextInputType.number),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: categoryValue,
                    icon: Icon(Icons.arrow_drop_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        categoryValue = newVal!;
                      });
                    },
                  ),
                ),
                CustomButton(label: 'Sell', onPressed: sellProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
