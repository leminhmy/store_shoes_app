import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/product.dart';

import '../../../components/base/app_variable.dart';
import '../../../components/big_text.dart';
import '../../../components/icon_and_text.dart';
import '../../../components/small_text.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class SliderBanner extends StatefulWidget {
  const SliderBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;

  double height = Dimensions.pageViewContainer;
  double index = 0;
  double scaleFactor = 0.8;
  List<ProductsModel> shoesProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    super.initState();
    shoesProduct = Get.find<ShoesController>().shoesProductList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ShoesController>(

      builder: (shoesController) {
        shoesProduct = Get.find<ShoesController>().shoesProductList;
        return Column(
          children: [
            SizedBox(
              height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: shoesProduct.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildSliderBannerCard(index,shoesProduct[index]);
                  }),
            ),
            buildDotsIndicator(),
          ],
        );
      }
    );
  }

  _buildSliderBannerCard(int index, ProductsModel shoesProduct) {
    height == 0 ? Dimensions.pageViewContainer : height;
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.width30),
        child: Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              //imageBackground banner
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getShoesDetail(shoesProduct.id!, "Home"));
                },
                child: Container(
                  height: Dimensions.pageViewContainer,
                  decoration: BoxDecoration(
                      color:
                          index.isEven ? AppColors.greenColor : Color(0xFF9294cc),
                      image: DecorationImage(
                          // image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!),
                          image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+shoesProduct.img!),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radius15))),
                ),
              ),

              //information banner
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(Dimensions.width20),
                  padding: EdgeInsets.only(right: Dimensions.width10,left: Dimensions.width10,top: Dimensions.height10),
                  height: Dimensions.pageViewTextContainer,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.paraColor,
                        blurRadius: 7,
                        spreadRadius: -3,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.radius20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        maxLines: 1,
                        text: shoesProduct.name!,
                        color: AppColors.mainBlackColor,
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: Dimensions.iconSize16,
                                    )),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          SmallText(text: "4.5"),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          SmallText(text: "1287 comments"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width50),
                  padding: EdgeInsets.all(Dimensions.width15),
                  height: Dimensions.height50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.paraColor,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 20),
                      ),
                    ],
                    borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius20)),
                  ),
                  child: Center(
                    child: BigText(text: AppVariable().numberFormatPriceVi(shoesProduct.price!),color: Colors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: shoesProduct.length > 0?shoesProduct.length:1,
      position: _currPageValue,
      decorator: DotsDecorator(
        activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
