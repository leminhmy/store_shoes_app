import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_shoes_app/components/base/app_variable.dart';
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
import '../../models/order.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_contants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'components/hearder_app_bar.dart';

class CartHistoryPage extends StatefulWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  State<CartHistoryPage> createState() => _CartHistoryPageState();
}

class _CartHistoryPageState extends State<CartHistoryPage> {
  List<Order> getCartHistoryList = [];
  String namePage = "Cart History";

  List<Widget> listStatusProduct = [
    Row(
      children: [
        const Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        SizedBox(
          width: Dimensions.height5,
        ),
        const SmallText(text: "Cancel"),
      ],
    ),
    Row(
      children: [
        const Icon(
          Icons.update,
          color: Colors.yellow,
        ),
        SizedBox(
          width: Dimensions.height5,
        ),
        const SmallText(text: "Accept"),
      ],
    ),
    Row(
      children: [
        const Icon(
          Icons.done_outline,
          color: Colors.green,
        ),
        SizedBox(
          width: Dimensions.height5,
        ),
        SmallText(text: "Finished"),
      ],
    ),
    Row(
      children: [
        const Icon(
          Icons.new_releases,
          color: Colors.yellow,
        ),
        SizedBox(
          width: Dimensions.height5,
        ),
        const SmallText(text: "Chờ duyệt"),
      ],
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<OrderController>().getOrderList();
    if (Get.find<AuthController>().userLoggedIn()) {

      getCartHistoryList = Get.find<OrderController>().order;

      if(Get.find<UserController>().userIsAdmin!){
        namePage = "List Order User";
      }
    }
  }

  Widget timeWidget(int index) {
    var outputDate = DateTime.now().toString();
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(getCartHistoryList[index].createdAt!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
    outputDate = outputFormat.format(inputDate);
    return BigText(text: outputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
        return GetBuilder<OrderController>(builder: (_orderController) {
          if (Get.find<AuthController>().userLoggedIn()) {
            getCartHistoryList = _orderController.order;
          }
          return Column(
            children: [
              HearderAppBar(namePage: namePage),
              //ListCart history
              authController.userLoggedIn()
                  ? (_orderController.order.isNotEmpty
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
                                  for (int i = 0;
                                      i < getCartHistoryList.length;
                                      i++)
                                    buildCartHistory(i),

                                ],
                              ),
                            ),
                          ),
                        )
                      : NoDataPage(
                          text: "Cart hisotry is empty!",
                          image: "assets/images/empty_box.png",
                        ))
                  : choosseSignin(),
            ],
          );
        });
      }),
    );
  }

  Container buildCartHistory(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              timeWidget(i),
              listStatusProduct[getCartHistoryList[i].status!],
            ],
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: List.generate(
                    getCartHistoryList[i].orderItems!.length, (index) {
                  ProductsModel product = ProductsModel.fromJson(jsonDecode(
                      getCartHistoryList[i].orderItems![index].shoesDetails!));
                  return index <= 2
                      ? Container(
                          height: Dimensions.height40 * 2,
                          width: Dimensions.width40 * 2,
                          margin:
                              EdgeInsets.only(right: Dimensions.width10 / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 / 2),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      product.img!),
                                  fit: BoxFit.cover)),
                        )
                      : Container();
                }),
              ),
              SizedBox(
                height: Dimensions.height40 * 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SmallText(text: "Total:", color: AppColors.titleColor),
                        SizedBox(width: Dimensions.height10,),
                        BigText(
                          text:
                          getCartHistoryList[i].orderItems!.length.toString() +
                              " Items",
                          color: AppColors.titleColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SmallText(text: "Price:", color: AppColors.titleColor),
                        SizedBox(width: Dimensions.height10,),
                        BigText(
                          text: AppVariable().numberFormatPriceVi(getCartHistoryList[i].orderAmount!),
                          color: AppColors.titleColor,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {

                        // test
                        List<dynamic> cartModelHistory =
                            getCartHistoryList[i].orderItems!;

                        Get.toNamed(
                            RouteHelper.getCartPage("carthistory", index: i));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height5,
                            horizontal: Dimensions.height10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15 / 3),
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
          ),
          getCartHistoryList[i].message != "null"? ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                title: BigText(text: "Message",color: AppColors.redColor,),
              children: [
                BigText(text: getCartHistoryList[i].message!,color: Colors.black,),
              ],
            ),
          ):Container(),
        ],
      ),
    );
  }
}

Widget choosseSignin() {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: Dimensions.height20 * 9,
            margin: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/signintocontinue.png"),
                )),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSignInPage());
            },
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height20 * 5,
              margin: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Center(
                  child: BigText(
                text: "Sign in",
                color: Colors.white,
                fontSize: Dimensions.font26,
              )),
            ),
          ),
        ],
      ),
    ),
  );
}
