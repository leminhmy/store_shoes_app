import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/border_radius_widget.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/product.dart';
import 'package:store_shoes_app/screens/home_page/main_home_page.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

import '../../../components/icon_background_border_radius.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class ImageBanner extends StatefulWidget {
  const ImageBanner({
    Key? key,
    required this.shoesProduct, required this.page, required this.listImg,
  }) : super(key: key);

  final String page;
  final ProductsModel shoesProduct;
  final List<String> listImg;

  @override
  State<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  PageController pageController = PageController();
  int _currPageValue = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      _currPageValue = pageController.page!.toInt()+1;
      setState(() {});

    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height50 * 7.8,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            SizedBox(
              height: Dimensions.height50 * 7,
              child: PageView.builder(
                controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.listImg.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: Dimensions.width5),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(Dimensions.radius40 * 3)),
                          image: DecorationImage(
                            image: NetworkImage(AppConstants.BASE_URL +
                                AppConstants.UPLOAD_URL +"shoes/"+
                                widget.listImg[index]),
                            fit: BoxFit.contain,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 10),
                              spreadRadius: -3,
                              blurRadius: 15,
                            )
                          ]),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.only(right: Dimensions.width20),
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: AppColors.redColor,
                    child: Center(
                      child: Icon(
                        Icons.favorite_outlined,
                        color: Colors.white,
                        size: Dimensions.iconSize26 * 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height5,
                    horizontal: Dimensions.width15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    )),
                child: BigText(
                  text: "Page: "+_currPageValue.toString()+"/"+widget.listImg.length.toString(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: Dimensions.height20,
                    horizontal: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if( widget.page == "cartpage"){
                            Get.toNamed(RouteHelper.getCartPage("cartpage",));
                          }
                          else if( widget.page == "carthistory"){
                            Get.back();
                          }
                          else{
                            Get.toNamed(RouteHelper.getInitial());
                          }
                        },
                        child: BorderRadiusWidget(
                            widget: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ))),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCartPage("cartpage",));
                            },
                            child: BorderRadiusWidget(
                                widget: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ))),
                        Get.find<ShoesController>().totalItems >= 1
                            ? Positioned(
                          right: 0,top: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              IconBackgroundBorderRadius(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.redColor,
                                sizeHeight: 20,
                                press: () {},
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: BigText(text: Get.find<ShoesController>().totalItems.toString(),color: Colors.white,fontSize: Dimensions.font12,)),
                            ],
                          ),
                        )
                            : Positioned(
                          right: 0,
                            top: 0,
                            child: Container()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
