import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/base/custom_loader.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/screens/detail_page/components/orther_product.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../components/border_radius_widget.dart';
import '../../controller/cart_controller.dart';
import 'components/bottom_bar_widget.dart';
import 'components/image_banner.dart';
import 'components/info_product.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key,required this.pageId, required this.page}) : super(key: key);
  int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    int index = Get.find<ShoesController>().shoesProductList.indexWhere((element) => element.id == pageId);
    var shoesDetail = Get.find<ShoesController>().shoesProductList[index];
    Get.find<ShoesController>()
        .initProduct(shoesDetail, Get.find<CartController>());

    return GetBuilder<ShoesController>(
      builder: (shoesController) {

        return Scaffold(
          body: shoesController.isLoaded?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageBanner(shoesProduct: shoesDetail, page: page,),
            SizedBox(
              height: Dimensions.height10,
            ),
            InfoProduct(shoesProduct: shoesDetail,),
            SizedBox(
              height: Dimensions.height15,
            ),
            OrtherProduct(),
          ],
        ),
        ):CustomLoader(),

        bottomNavigationBar: BottomBarWidget(shoesController: shoesController, productShoesDetail: shoesDetail,),
        );
      }
    );
  }
}

