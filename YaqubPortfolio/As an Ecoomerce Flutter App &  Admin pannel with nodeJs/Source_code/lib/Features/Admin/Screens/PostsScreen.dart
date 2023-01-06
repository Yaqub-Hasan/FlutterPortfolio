import 'package:clone/Features/Account/Widgets/SingleProduct.dart';
import 'package:clone/Features/Admin/Server/admin_services.dart';
import 'package:clone/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'AddProductsScreen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  AdminServices adminServices = AdminServices();
  List<Product>? products;

  void fetchAllProduct() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddProductsScreen() {
    Navigator.pushNamed(context, AddProductsScreen.name);
  }

  void deleteProduct(Product product , int index){
    adminServices.deleteProduct(context: context, product: product, onSuccess: (){
     products!.removeAt(index);
     setState(() {});
    });
  }

  @override
  void initState() {
    fetchAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: GridView.builder(
                padding: EdgeInsets.all(1.w),
                itemCount: products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,
                crossAxisSpacing: 2.w
                ), itemBuilder: (context , index){
              final productData = products![index];
              return Column(
                children: [
                  Expanded(
                  child: SingleProduct(
                    image: productData.images[0]
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 1.w,),
                      Expanded(child: Text(productData.name , overflow: TextOverflow.ellipsis , maxLines: 2,)),
                      IconButton(onPressed:() => deleteProduct(productData , index), icon: Icon(Icons.delete_outline))
                    ],
                  )
                ],
              );
            }),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a product',
              onPressed: () {
                navigateToAddProductsScreen();
              },
              child: Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
