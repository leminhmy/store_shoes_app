import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/components/base/custom_loader.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/controller/map_controller.dart';
import 'package:store_shoes_app/controller/messages_controller.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/severs/sever_socketio/socketio_client.dart';

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
    Key? key,
    required this.page,
    required this.index,
  }) : super(key: key);
  final String page;
  final int index;

  @override
  State<BottomBarCart> createState() => _BottomBarCartState();
}

class _BottomBarCartState extends State<BottomBarCart> {
  late int selectedIndex;
  Order orderModel = Order();
  late TextEditingController address;
  TextEditingController message = TextEditingController(text: "null");
  late BuildContext dialogLoadingContext;

  //dropmenu address
  String? selectedItemDistrict;
  String? selectedItemCommune;
  String? selectedItemProvine;

  String location = "";


  //default
  List<String> stringStatus = ["Cancel","Accpet","Finished"];


   _updateStatus(int idOrder, int statusOrder)  {
     String maptext = "null";
     if(message.value.text != "null"){
       maptext= message.value.text;
     }
    Map map = {"message": maptext};
     Get.find<OrderController>()
        .updateStatusOrder(idOrder, statusOrder, map)
        .then((status) {
      if (status.isSuccess) {
        showCustomSnackBar("Change Status Success", isError: false);
        String messageCancel = "";
        if(message.value.text != "null"){
          messageCancel = "Messages: "+message.value.text;
        }
        Get.find<MessagesController>().sendNotification(typeNotification: "order",title: "Order id:"+orderModel.id.toString(), content: "Change to "+stringStatus[selectedIndex]+messageCancel, userId: orderModel.userId!);
        SeverSocketIo().sendData(orderModel.userId!, "order");
        Get.find<OrderController>().getOrderList();
        selectedIndex = statusOrder;
      } else {
        showCustomSnackBar(status.message);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = 3;
    address = TextEditingController(text: "");
    if (widget.page == "carthistory") {
      orderModel = Get.find<OrderController>().order[widget.index];
      selectedIndex = orderModel.status!;
    }
    Get.find<MapController>().getMapProvine();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.page != "carthistory"
          ? Dimensions.height30 * 4
          : Dimensions.height30 * 6,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
          vertical: widget.page != "carthistory"
              ? Dimensions.height30
              : Dimensions.height5),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius30),
            topRight: Radius.circular(Dimensions.radius30)),
      ),
      child: widget.page != "carthistory"
          ? GetBuilder<CartController>(builder: (cartController) {
              return cartController.getItems.isNotEmpty
                  ? Row(
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
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setStateDialog) {

                                      return AlertDialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.height10),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        title: Text('Nh???p ?????a Ch???'),
                                        content: SizedBox(
                                          height: Dimensions.height50 * 8,
                                          width: Dimensions.screenWidth * 0.9,
                                          child: GetBuilder<MapController>(
                                              builder: (mapController) {
                                             if(selectedItemProvine != null && selectedItemDistrict != null && selectedItemCommune != null){
                                               location = address.value.text+", "
                                                   +selectedItemCommune!+", "
                                                   +selectedItemDistrict!+", "
                                                   +selectedItemProvine!;
                                             }
                                             else{
                                               location = address.value.text;
                                             }
                                            return SingleChildScrollView(
                                              physics: const BouncingScrollPhysics(),
                                              padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                                              child: Column(
                                                children: [
                                                  DropdownButtonFormField<
                                                      String>(
                                                    iconEnabledColor:
                                                        AppColors.mainColor,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "T???nh/Th??nh Ph???",
                                                      labelStyle: TextStyle(
                                                        fontSize:
                                                            Dimensions.font22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimensions
                                                                      .height10),
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .paraColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    value: selectedItemProvine,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setStateDialog(() {
                                                        selectedItemProvine =
                                                            newValue;
                                                      });
                                                    },
                                                    items: mapController
                                                        .mapProvine
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        onTap: () {
                                                          mapController
                                                              .getMapDistrict(item
                                                                  .idProvince!);

                                                          setStateDialog((){
                                                            setState(() {
                                                              selectedItemDistrict = null;
                                                              selectedItemCommune = null;
                                                            });
                                                          });


                                                        },
                                                        child: BigText(
                                                          text: item.name!,
                                                          color: Colors.black,
                                                        ),
                                                        value: item.name,
                                                      );
                                                    }).toList(),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  mapController.mapDistrict.isNotEmpty?DropdownButtonFormField<
                                                      String>(
                                                    iconEnabledColor:
                                                        AppColors.mainColor,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      labelText: "Qu???n/Huy???n",
                                                      labelStyle: TextStyle(
                                                        fontSize:
                                                            Dimensions.font22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimensions
                                                                      .height10),
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .paraColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    value: selectedItemDistrict,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setStateDialog(() {
                                                        selectedItemDistrict =
                                                            newValue;
                                                      });
                                                    },
                                                    items: mapController
                                                        .mapDistrict
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        onTap: () {
                                                          mapController
                                                              .getMapCommune(item
                                                                  .idDistrict!);
                                                          setStateDialog((){
                                                            setState(() {
                                                              selectedItemCommune = null;

                                                            });
                                                          });
                                                        },
                                                        child: BigText(
                                                          text: item.name!,
                                                          color: Colors.black,
                                                        ),
                                                        value: item.name,
                                                      );
                                                    }).toList(),
                                                  ):CustomLoader(),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  mapController.mapCommune.isNotEmpty?DropdownButtonFormField<
                                                      String>(
                                                    iconEnabledColor:
                                                        AppColors.mainColor,
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      labelText: "X??/Ph?????ng",
                                                      labelStyle: TextStyle(
                                                        fontSize:
                                                            Dimensions.font22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimensions
                                                                      .height10),
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .paraColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    value: selectedItemCommune,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setStateDialog(() {
                                                        selectedItemCommune =
                                                            newValue;
                                                      });
                                                    },
                                                    items: mapController
                                                        .mapCommune
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        child: BigText(
                                                          text: item.name!,
                                                          color: Colors.black,
                                                        ),
                                                        value: item.name,
                                                      );
                                                    }).toList(),
                                                  ):CustomLoader(),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  EditTextForm(
                                                    hintText: "S??? nh??/Khu ph???-T???, H???m,...",
                                                      controller: address,
                                                      minLines: 3,
                                                      labelText: "?????a ch??? chi ti???t"),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  Wrap(
                                                    children: [
                                                      BigText(text: "?????a Ch???: "),
                                                      BigText(text: location,color: AppColors.redColor,),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        List<
                                                                Map<String,
                                                                    dynamic>>
                                                            cart = [];
                                                        Get.find<
                                                                CartController>()
                                                            .getItems
                                                            .forEach((element) {
                                                          Map<String, dynamic>
                                                              map = {};
                                                          map = {
                                                            "id": element.id,
                                                            "quantity": element
                                                                .quantity,
                                                            "name":
                                                                element.name,
                                                            "color":
                                                                element.color,
                                                            "size":
                                                                element.size,
                                                            "img": element.img
                                                          };
                                                          cart.add(map);
                                                        });
                                                        if (address
                                                                .value.text ==
                                                            "" && selectedItemProvine == null && selectedItemDistrict ==null && selectedItemCommune ==  null) {
                                                          showCustomSnackBar(
                                                              "Address is Empty",
                                                              title:
                                                                  "Error Address");
                                                        }
                                                        if (cart.isEmpty) {
                                                          showCustomSnackBar(
                                                              "Cart is Empty",
                                                              title:
                                                                  "Error Cart");
                                                        } else {
                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                dialogLoadingContext =
                                                                    context;
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircularProgressIndicator(),
                                                                    BigText(
                                                                        text:
                                                                            "Are ordering"),
                                                                  ],
                                                                );
                                                              });
                                                          Get.find<
                                                                  OrderController>()
                                                              .placeOrder(
                                                                  location,
                                                                  cartController
                                                                      .totalAmount,
                                                                  cart)
                                                              .then((status) {
                                                            if (status
                                                                .isSuccess) {
                                                              Get.find<MessagesController>().sendNotification(typeNotification: "order",title: "Order new:", content: "Address: "+location, userId: Get.find<UserController>().listUsers[0].id!);
                                                              SeverSocketIo().sendData(Get.find<UserController>().listUsers[0].id!, "order");
                                                              Navigator.pop(
                                                                  dialogLoadingContext);
                                                              showCustomSnackBar(
                                                                  "Order Success",
                                                                  isError:
                                                                      false);
                                                              Get.find<
                                                                      CartController>()
                                                                  .clear();
                                                              Get.find<
                                                                      ShoesController>()
                                                                  .updateShoesController();
                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              showCustomSnackBar(
                                                                  status
                                                                      .message);
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: ButtonBorderRadius(
                                                          colorBackground:
                                                              AppColors
                                                                  .mainColor,
                                                          widget: BigText(
                                                            text: "Order",
                                                            color: Colors.white,
                                                          ))),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    });
                                  });
                            } else {
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
                    )
                  : Container();
            })
          : GetBuilder<OrderController>(
            builder: (orderController) {
              orderModel = orderController.order[widget.index];
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Get.find<UserController>().userIsAdmin!
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  const BigText(
                                    text: "Total Price:",
                                    color: AppColors.btnClickColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    width: Dimensions.height10,
                                  ),
                                  BigText(
                                    text: AppVariable().numberFormatPriceVi(
                                        orderModel.orderAmount!),
                                    color: AppColors.btnClickColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  selectedIndex == 3
                                      ? BigText(
                                          text: "??ang ?????i",
                                          fontSize: Dimensions.font26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: Dimensions.height10,
                                  ),
                                  BigText(
                                    text: "X??? L??",
                                    fontSize: Dimensions.font26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height5,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    3,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        if (index != selectedIndex) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions.radius10),
                                                    ),
                                                    title: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons
                                                              .warning_amber_rounded,
                                                          color: Colors.yellow,
                                                        ),
                                                        Text("Warning"),
                                                      ],
                                                    ),
                                                    content: SizedBox(
                                                      height: index == 0
                                                          ? Dimensions.height50 * 4
                                                          : null,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            index == 1
                                                                ? Text(
                                                                    "You want change to Accept!")
                                                                : index == 2
                                                                    ? Text(
                                                                        "You want change to Finished!")
                                                                    : Text(
                                                                        "You want Cancel it!"),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height10,
                                                            ),
                                                            index == 0
                                                                ? EditTextForm(
                                                                    hintText:
                                                                        "Message",
                                                                    controller:
                                                                        message,
                                                                    minLines: 3,
                                                                    labelText:
                                                                        "Message")
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Change"),
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedIndex = index;
                                                          });
                                                          Get.back();
                                                        },
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            message = TextEditingController(text: "null");
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("Cancel")),
                                                    ],
                                                  ));
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.height5,
                                            horizontal: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            color: selectedIndex == index
                                                ? AppColors.mainColor
                                                : null,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius10 / 2),
                                            border: Border.all(
                                              color: AppColors.mainColor,
                                              width: 2,
                                            )),
                                        child: Row(
                                          children: [
                                            index == 0
                                                ? const Icon(
                                                    Icons.cancel,
                                                    color: Colors.red,
                                                  )
                                                : index == 1
                                                    ? const Icon(
                                                        Icons.update,
                                                        color: Colors.yellow,
                                                      )
                                                    : const Icon(
                                                        Icons.done_outline,
                                                        color: Colors.green,
                                                      ),
                                            SizedBox(
                                              width: Dimensions.height5,
                                            ),
                                            index == 0
                                                ? const SmallText(
                                                    text: "Cancel",
                                                    color: Colors.black,
                                                  )
                                                : index == 1
                                                    ? const SmallText(
                                                        text: "Accept",
                                                        color: Colors.black)
                                                    : const SmallText(
                                                        text: "Finished",
                                                        color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (selectedIndex != orderModel.status) {
                                      _updateStatus(orderModel.id!, selectedIndex);
                                      setState(() {

                                      });
                                    }

                                    print(selectedIndex);
                                    print(orderModel.status);
                                    print("taped");
                                  },
                                  child: ButtonBorderRadius(
                                      widget: BigText(
                                    text: "Save",
                                  ))),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BigText(
                                text: "Total Price:",
                                color: AppColors.btnClickColor,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: Dimensions.height10,
                              ),
                              BigText(
                                text: AppVariable()
                                    .numberFormatPriceVi(orderModel.orderAmount!),
                                color: AppColors.btnClickColor,
                              ),
                            ],
                          ),
                  ],
                );
            }
          ),
    );
  }
}
