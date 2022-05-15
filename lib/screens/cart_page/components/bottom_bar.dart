import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/controller/order_controller.dart';

import '../../../components/base/app_variable.dart';
import '../../../components/base/show_custom_snackbar.dart';
import '../../../components/big_text.dart';
import '../../../components/button_border_radius.dart';
import '../../../components/edit_text_form.dart';
import '../../../components/small_text.dart';
import '../../../controller/user_controller.dart';
import '../../../models/order.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class BottomBarCart extends StatefulWidget {
  const BottomBarCart({
    Key? key, required this.page, required this.index,
  }) : super(key: key);
  final String page;
  final int index;

  @override
  State<BottomBarCart> createState() => _BottomBarCartState();
}

class _BottomBarCartState extends State<BottomBarCart> {
  int selectedIndex = 3;
  Order orderModel = Order();
  late TextEditingController address;
  TextEditingController message = TextEditingController();
  late BuildContext dialogLoadingContext;
  String messageText = "null";



  Future<void> _updateStatus(int idOrder, int statusOrder) async {
    Map map = {"message": messageText};
    await Get.find<OrderController>().updateStatusOrder(idOrder, statusOrder,map).then((status){
      if(status.isSuccess){
        showCustomSnackBar("Change Status Success",isError: false);
        Get.find<OrderController>().getOrderList();
        setState(() {
          selectedIndex = statusOrder;
        });
      }else{
        showCustomSnackBar(status.message);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    messageText = "null";
    address = TextEditingController(text: "address");
    if(widget.page == "carthistory"){
      orderModel = Get.find<OrderController>().order[widget.index];
      selectedIndex = orderModel.status!;
      print(orderModel.id);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.page != "carthistory"?Dimensions.height30*4:Dimensions.height30*6,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20, vertical: widget.page != "carthistory"?Dimensions.height30:Dimensions.height5),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius30),
            topRight: Radius.circular(Dimensions.radius30)),
      ),
      child: widget.page != "carthistory"?GetBuilder<CartController>(
        builder: (cartController) {
          return cartController.getItems.isNotEmpty?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //quantity
              ButtonBorderRadius(
                  widget: BigText(
                    text: "\$ ${cartController.totalAmount}",
                    color: Colors.black,
                  )),
              //addToCard
              GestureDetector(
                onTap: (){
                  if(Get.find<AuthController>().userLoggedIn())
                    {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context,setStateDialog) {
                                  return AlertDialog(
                                    title: Text('Nhập Địa Chỉ'),
                                    content: SizedBox(
                                      height: Dimensions.height50*4,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            EditTextForm(
                                                controller: address,
                                                minLines: 3,
                                                labelText: "Address"),
                                            SizedBox(height: Dimensions.height10,),
                                            GestureDetector(
                                                onTap: () {
                                                  List<Map<String, dynamic>> cart = [];
                                                  Get.find<CartController>().getItems.forEach((element) {
                                                    Map<String, dynamic> map = {};
                                                    map = {"id":element.id,"quantity":element.quantity,"name":element.name,"color":element.color,"size":element.size,"img":element.img};
                                                    cart.add(map);
                                                  });
                                                  if(address.value.text == ""){
                                                    showCustomSnackBar("Address is Empty",title: "Error Address");
                                                  }
                                                  if(cart.isEmpty){
                                                    showCustomSnackBar("Cart is Empty",title: "Error Cart");
                                                  }
                                                  else{
                                                    showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          dialogLoadingContext = context;
                                                          return Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              CircularProgressIndicator(),
                                                              BigText(text: "Đang login"),
                                                            ],
                                                          );
                                                        });
                                                    Get.find<OrderController>().placeOrder(address.value.text, cartController.totalAmount, cart).then((status) {
                                                      if(status.isSuccess){
                                                        Navigator.pop(dialogLoadingContext);
                                                        Get.find<CartController>().clear();
                                                        showCustomSnackBar("Order Success",isError: false);
                                                        Navigator.pop(context);
                                                        setState(() {

                                                        });
                                                      }else{
                                                        showCustomSnackBar(status.message);
                                                      }
                                                    });
                                                  }

                                                },
                                                child: ButtonBorderRadius(
                                                  colorBackground: AppColors.mainColor,
                                                    widget: BigText(
                                                      text: "Order",color: Colors.white,
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          });

                    }
                  else{
                          Get.toNamed(RouteHelper.getSignInPage());

                  }

                },
                child: ButtonBorderRadius(
                  widget: BigText(
                    text: "Check out",
                    color: Colors.white,
                  ),
                  colorBackground: AppColors.mainColor,
                ),
              )
            ],
          ):Container();
        }
      ):Column(
        children: [
          Row(
            children: [
              const BigText(text: "Total Price:", color: AppColors.btnClickColor,fontWeight: FontWeight.bold,),
              SizedBox(width: Dimensions.height10,),
              BigText(
                text: AppVariable().numberFormatPriceVi(orderModel.orderAmount!),
                color: AppColors.btnClickColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedIndex == 3?BigText(text: "Đang đợi",fontSize: Dimensions.font26,fontWeight: FontWeight.bold,color: Colors.yellow,):Container(),
              SizedBox(width: Dimensions.height10,),
              BigText(text: "Xử Lý",fontSize: Dimensions.font26,fontWeight: FontWeight.bold,),
            ],
          ),
          SizedBox(height: Dimensions.height5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) => GestureDetector(
              onTap: (){
                if(index != selectedIndex){
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius10),
                        ),
                        title: Row(
                          children: const [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.yellow,
                            ),
                            Text("Warning"),
                          ],
                        ),
                        content: SizedBox(
                          height: index == 0?Dimensions.height50*4:null,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                index==1?Text("You want change to Accept!"):index == 2?Text("You want change to Finished!"):Text("You want Cancel it!"),
                                SizedBox(height: Dimensions.height10,),
                                index == 0?  EditTextForm(
                                  hintText: "Message",
                                    controller: message,
                                    minLines: 3,
                                    labelText: "Message"):Container(),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text("Change"),
                            onPressed: () {
                              setState(() {
                                messageText = message.value.text;
                                selectedIndex = index;

                              });
                              Get.back();
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      ));
                }


              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height5,horizontal: Dimensions.height10),
                decoration: BoxDecoration(
                  color: selectedIndex == index ?AppColors.mainColor:null,
                    borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                    border: Border.all(
                      color: AppColors.mainColor,
                      width: 2,
                    )
                ),
                child: Row(
                  children: [
                    index == 0?const Icon(Icons.cancel,color: Colors.red,):
                    index == 1?const Icon(Icons.update,color: Colors.yellow,):
                    const Icon(Icons.done_outline,color: Colors.green,),
                    SizedBox(width: Dimensions.height5,),
                    index == 0?const SmallText(text: "Cancel",color: Colors.black,):
                    index == 1?const SmallText(text: "Accept",color: Colors.black):
                    const SmallText(text: "Finished",color: Colors.black),
                  ],
                ),
              ),
            ),)
          ),
          SizedBox(height: Dimensions.height10,),
          GestureDetector(
              onTap: () {
                if(selectedIndex != orderModel.status){
                  _updateStatus(orderModel.id!,selectedIndex);
                }
              },
              child: ButtonBorderRadius(
                  widget: BigText(
                    text: "Save",
                  ))),
        ],
      ),
    );
  }
}
