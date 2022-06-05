import 'dart:convert';
import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:store_shoes_app/components/base/app_variable.dart';
import 'package:store_shoes_app/components/base/custom_loader.dart';
import 'package:store_shoes_app/components/base/no_data_page.dart';
import 'package:store_shoes_app/components/button_border_radius.dart';
import 'package:store_shoes_app/components/edit_text_form.dart';
import 'package:store_shoes_app/components/icon_background_border_radius.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/product.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/home_page/components/edit_product.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

import '../../../components/app_text_field.dart';
import '../../../components/base/show_custom_snackbar.dart';
import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../detail_page/detail_page.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    Key? key,
    required this.shoesProduct,
  }) : super(key: key);

  final List<ProductsModel> shoesProduct;

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  DraggableScrollableController _dragScrollController =
  DraggableScrollableController();
  late double maxChildeSize = 0.3;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "Popular",
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: Dimensions.font26,
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
        widget.shoesProduct.isNotEmpty?Column(
            children: List.generate(widget.shoesProduct.length, (index) {
              return GestureDetector(
                onLongPress: () {

                  Get.find<AuthController>().userLoggedIn()?showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return makeDismissible(
                            context: context,
                            child: DraggableScrollableSheet(
                                maxChildSize: 0.9,
                                minChildSize: 0.1,
                                initialChildSize: maxChildeSize,
                                controller: _dragScrollController,
                                builder: (context, _controller) {
                                  return EditProduct(controller: _controller, index: index, context: context,
                                    dragScrollController: _dragScrollController,
                                    shoesProduct: widget.shoesProduct,onTapEditText: (){
                                      _dragScrollController.animateTo(maxChildeSize = 0.9,
                                          duration: const Duration(milliseconds: 200),
                                          curve: Curves.ease);
                                    }, );
                                }));
                      }).whenComplete(() => {maxChildeSize = 0.3}):null;



                },
                onTap: () {
                  Get.toNamed(RouteHelper.getShoesDetail(
                      widget.shoesProduct[index].id!, "home"));
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.height20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20)),
                    child: SizedBox(
                      height: Dimensions.height50 * 5,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                                image: DecorationImage(
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        widget.shoesProduct[index].img!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,vertical:Dimensions.height5 ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width20,
                                        vertical: Dimensions.width10),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius:
                                      BorderRadius.circular(Dimensions.radius10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:Dimensions.height50*3,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                maxLines: 1,
                                                  text:
                                                  widget.shoesProduct[index].name!,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              SmallText(
                                                maxLines: 1,
                                                text: widget
                                                    .shoesProduct[index].subTitle ??
                                                    "None",
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Price: 150.000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                decoration:
                                                TextDecoration.lineThrough,
                                                decorationColor: Colors.red,
                                              ),
                                            ),
                                            
                                            BigText(
                                              text: AppVariable().numberFormatPriceVi(
                                                  widget.shoesProduct[index].price!),
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Dimensions.font20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: Dimensions.height30 * 2.5,
                                width: Dimensions.width50,
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/sellera.png"),
                                        fit: BoxFit.cover)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SmallText(
                                        text: "SELL",
                                        color: Colors.amberAccent,
                                      ),
                                      BigText(
                                        text: "33%",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ):NoDataPage(text: "Popular is Empty"),
        ],
      ),
    );
  }

  Widget makeDismissible(
      {required Widget child, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

}
