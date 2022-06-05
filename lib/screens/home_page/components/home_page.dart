import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/components/base/custom_loader.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../../components/big_text.dart';
import '../../../components/icon_and_text.dart';
import '../../../components/small_text.dart';
import '../../../controller/order_controller.dart';
import 'app_bar_home.dart';
import 'category.dart';
import 'popular_product.dart';
import 'slider_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> getData()async {
    Get.find<ShoesController>().getShoesProductList();
    Get.find<ShoesController>().getShoesTypeList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.yellow,
        onRefresh: getData,
        child: ListView(
          children: [
            GetBuilder<ShoesController>(
          builder: (shoesController) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: Dimensions.height30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarHome(),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    SliderBanner(),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Category(shoesType: shoesController.shoesTypeList, shoesController: shoesController,),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    shoesController.isLoaded?PopularProducts(shoesProduct: shoesController.listFilterShoes,):CustomLoader(),
                  ],
                ),
              ),
            );
          }
        )
          ],
        ),
      ),
    );
  }
}

