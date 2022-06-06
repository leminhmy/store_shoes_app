import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/cart_model.dart';
import 'package:store_shoes_app/models/product.dart';
import 'package:store_shoes_app/components/search_widget.dart';

import '../../components/big_text.dart';
import '../../components/small_text.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_contants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<ProductsModel> shoesProduct = [];
  TextEditingController controller = TextEditingController();
  late String query;
  late ValueChanged<String> onChanged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = '';
    shoesProduct = Get.find<ShoesController>().shoesProductList;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SearchWidget(

          text: query,
          hintText: 'Search Name or SubTitle',
          onChanged: searchBook,
        )

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: Dimensions.height20,right: Dimensions.height10,left: Dimensions.height10),
          child: Column(
            children: List.generate(
              shoesProduct.length,
                  (index) {
                    return GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getShoesDetail(shoesProduct[index].id!, "home"));
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: Dimensions.height10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //image product
                              ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.radius20)),
                                  child: Image.network(
                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+shoesProduct[index].img!,
                                    fit: BoxFit.cover,
                                    height: Dimensions.pageViewTextContainer,
                                    width: Dimensions.pageViewTextContainer,
                                  )
                              ),
                              //information product
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(Dimensions.width10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.radius10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.paraColor.withOpacity(0.1),
                                          blurRadius: 1,
                                        ),

                                      ]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(text: shoesProduct[index].name!),
                                      SizedBox(height: Dimensions.height5,),
                                      SmallText(text: shoesProduct[index].subTitle!,color: Colors.black,),
                                      SizedBox(height: Dimensions.height5,),
                                      BigText(text: shoesProduct[index].price!.toString(),color: AppColors.redColor,),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  }
                 ,
            ),
          ),
        ),
      ),
    );
  }

  void searchBook(String query) {
    final shoesProduct = Get.find<ShoesController>().shoesProductList.where((shoes) {
      final nameLower = shoes.name!.toLowerCase();
      final subTitleLower = shoes.subTitle!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          subTitleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.shoesProduct = shoesProduct;
    });
  }
}
