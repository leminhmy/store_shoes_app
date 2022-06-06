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
import '../../models/product.dart';
import 'components/bottom_bar_widget.dart';
import 'components/image_banner.dart';
import 'components/info_product.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.pageId, required this.page})
      : super(key: key);
  int pageId;
  final String page;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> listSize = [];
  List<String> listImg = [];
  List<String> listColor = [];
  List<int> listSizeInt = [];
  late int index;
  late ProductsModel shoesDetail;
  List<ProductsModel> listOtherProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




    index = Get.find<ShoesController>()
        .shoesProductList
        .indexWhere((element) => element.id == widget.pageId);
    shoesDetail = Get.find<ShoesController>().shoesProductList[index];

    String size = Get.find<ShoesController>().shoesProductList[index].size!;
    String color = Get.find<ShoesController>().shoesProductList[index].color!;
    String listImgApiBase =
        Get.find<ShoesController>().shoesProductList[index].listimg!;
    String listImgApi = listImgApiBase.substring(0, listImgApiBase.length - 1);
    //change stringSize product to list
    listSize = (size.split(','));
    listSizeInt = listSize.map(int.parse).toList();

    //change stringColor product api to list
    listColor = (color.split(','));

    listImg = (listImgApi.split(','));

    Get.find<ShoesController>()
        .setDefaultSizeAndColor(listSizeInt[0], listColor[0]);
    Get.find<ShoesController>()
        .initProduct(shoesDetail, Get.find<CartController>(),listSizeInt[0],listColor[0]);

    listOtherProduct = Get.find<ShoesController>().getOtherProductList(shoesDetail.typeId!);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageBanner(
                    shoesProduct: shoesDetail,
                    page: widget.page,
                    listImg: listImg,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  InfoProduct(
                    shoesProduct: shoesDetail,
                    listColor: listColor,
                    listSize: listSizeInt,
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  OrtherProduct(listOtherProduct: listOtherProduct),
                ],
              ),
            )
         ,
      bottomNavigationBar: GetBuilder<ShoesController>(
        builder: (shoesController) {
          return BottomBarWidget(
            shoesController: shoesController,
            productShoesDetail: shoesDetail,
          );
        }
      ),
    );
  }
}
