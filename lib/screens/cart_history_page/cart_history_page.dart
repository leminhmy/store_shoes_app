import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_shoes_app/components/base/custom_loader.dart';
import 'package:store_shoes_app/controller/user_controller.dart';
import 'package:store_shoes_app/models/product.dart';

import '../../components/base/no_data_page.dart';
import '../../components/big_text.dart';
import '../../components/small_text.dart';
import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/order_controller.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_contants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'components/hearder_app_bar.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;*/
    Get.find<OrderController>().getOrderList();
    var getCartHistoryList;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(getCartHistoryList[index].createdAt!);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
          outputDate = outputFormat.format(inputDate);
      return BigText(text: outputDate);
    }


    return Scaffold(
      body: Column(
        children: [
          HearderAppBar(),
          //ListCart history
          Get.find<AuthController>().userLoggedIn()?(Get.find<OrderController>().order.isNotEmpty?GetBuilder<OrderController>(builder: (_orderController) {
            getCartHistoryList = _orderController.order;
            return _orderController.order.isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < getCartHistoryList.length; i++)
                              Container(
                                height: Dimensions.height30 * 4,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(i),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              getCartHistoryList[i].orderItems!.length, (index) {
                                                ProductsModel product = ProductsModel.fromJson(jsonDecode(getCartHistoryList[i].orderItems![index].shoesDetails!));
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        Dimensions.height40 * 2,
                                                    width:
                                                        Dimensions.width40 * 2,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                            image: NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                product.img!),
                                                            fit: BoxFit.cover)),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height40 * 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor),
                                              BigText(
                                                text: getCartHistoryList[i].orderItems!.length
                                                        .toString() +
                                                    " Items",
                                                color: AppColors.titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  /*var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItemsHistory = moreOrder;
                                                  Get.toNamed(
                                                      RouteHelper.cartPage);*/

                                                  // test
                                                    List<dynamic> cartModelHistory = getCartHistoryList[i].orderItems!;

                                                    Get.toNamed(RouteHelper.getCartPage("carthistory",index: i));

                                                    /*var testList = [];
                                                    getCartHistoryList[i].orderItems!.forEach((element) {
                                                      testList.add(jsonEncode(element));
                                                      print(testList);
                                                    }
                                                    );*/
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          Dimensions.height5,
                                                      horizontal:
                                                          Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          AppColors.mainColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                3),
                                                  ),
                                                  child: SmallText(
                                                    text: "one more",
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  )
                : NoDataPage(
                    text: "Cart hisotry is empty!",
                    image: "assets/images/empty_box.png",
                  );
          }):CustomLoader()):choosseSignin()
        ],
      ),
    );
  }
}

Widget choosseSignin(){
  return Container(child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          height: Dimensions.height20*9,
          margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/signintocontinue.png"),
              )
          ),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getSignInPage());
          },
          child: Container(
            width: double.maxFinite,
            height: Dimensions.height20*5,
            margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
            child: Center(child: BigText(text: "Sign in",color: Colors.white,fontSize: Dimensions.font26,)),
          ),
        ),

      ],
    ),
  ),);
}