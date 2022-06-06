import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/components/base/show_custom_snackbar.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/home_page/components/edit_image_product.dart';

import '../../../components/big_text.dart';
import '../../../components/button_border_radius.dart';
import '../../../components/edit_text_form.dart';
import '../../../controller/shoes_controller.dart';
import '../../../models/product.dart';
import '../../../models/shoes_type.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class EditProduct extends StatefulWidget {
  const EditProduct(
      {Key? key,
      required this.controller,
      required this.index,
      required this.context,
      required this.dragScrollController,
      required this.shoesProduct,
      required this.onTapEditText})
      : super(key: key);

  final ScrollController controller;
  final int index;
  final BuildContext context;
  final DraggableScrollableController dragScrollController;
  final List<dynamic> shoesProduct;
  final VoidCallback onTapEditText;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  late ProductsModel productsModel;
  double _currPageValue = 0;
  bool releasedProduct = false;
  late TextEditingController name;
  late TextEditingController subTitle;
  late TextEditingController price;
  late TextEditingController description;

   List<String> listImg = [];
  String listImgApi = '';
  String listImgApiBase = '';
  String listColorApi = '';
  String listSizeApi = '';
   List<String> listColor = [];
   List<String> listSize = [];
  late Color color;

  //select type
  List<String> shoesTypeList = [];
  List<ShoesTypeModel> shoesTypeListModel = [];
  String? _selectedType;
  int? _selectedTypeInt;

  String sizeIndexPicker = '';
  final pickItemsSize = [];
  late BuildContext dialogContext;

  PageController pageController = PageController(viewportFraction: 0.89);

  @override
  void initState() {
    // TODO: implement initState
    productsModel = Get.find<ShoesController>().shoesProductList[widget.index];
    name = TextEditingController(text: Get.find<ShoesController>().shoesProductList[widget.index].name!);
    subTitle = TextEditingController(text: Get.find<ShoesController>().shoesProductList[widget.index].subTitle!);
    price = TextEditingController(text: Get.find<ShoesController>().shoesProductList[widget.index].price!.toString());
    description = TextEditingController(text: Get.find<ShoesController>().shoesProductList[widget.index].description!);


    pageController.addListener(() {
      _currPageValue = pageController.page!;
      setState(() {});
    });
    super.initState();
    listImgApiBase = Get.find<ShoesController>().shoesProductList[widget.index].listimg!;
    listImgApi = listImgApiBase.substring(0,listImgApiBase.length - 1);
    listColorApi = Get.find<ShoesController>().shoesProductList[widget.index].color!;
    listSizeApi = Get.find<ShoesController>().shoesProductList[widget.index].size!;
    listImg = convertDataStringToList(listImgApi);
    listColor = convertDataStringToList(listColorApi);
    listSize = convertDataStringToList(listSizeApi);
    pickItemsSize.addAll([
      for (int i = 20; i < 60; i++) "${i.toString()}",
    ]);

    color = Color(0xFFFFFFFF);
    sizeIndexPicker = pickItemsSize[0];

    //select type
    shoesTypeListModel = Get.find<ShoesController>().shoesTypeList;
    shoesTypeListModel.forEach((element) {
      shoesTypeList.add(element.name!);
    });
    //selected type default
    shoesTypeListModel.forEach((element) {
      if(element.id == Get.find<ShoesController>().shoesProductList[widget.index].typeId!){
        _selectedType = element.name!;
        _selectedTypeInt = element.id;

      }
    });

    print(_selectedType);
  }

  List<String> convertDataStringToList(String dataString) {
    List<String> listData = [];
    listData = (dataString.split(','));
    return listData;
  }

  deleteProduct(int idProduct){

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              BigText(text: "Đang up load"),
            ],
          );
        });

    Get.find<ShoesController>().deleteProduct(idProduct).then((status) {
      if(status.isSuccess){
        Navigator.pop(dialogContext);
        Navigator.pop(context);
        Navigator.pop(context);
        Get.find<ShoesController>().getShoesProductList();
        showCustomSnackBar("DeleteProduct success",isError: false);

      }
      else{
        Navigator.pop(dialogContext);
        showCustomSnackBar(status.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Map mapPostData = {
      "name": name.value.text,
      "sub_title": subTitle.value.text,
      "price":price.value.text,
      "type_id": _selectedTypeInt,
      "description":description.value.text,
      "color":listColor.toString().replaceAll('[', '').replaceAll(']',''),
      "size":listSize.toString().replaceAll('[', '').replaceAll(']',''),
      "released": releasedProduct?0:1
    };

    Future<void> updateProduct(ShoesController shoesController)async{
      if(name.value.text == ""){
        showCustomSnackBar("Name is Empty",title: "Error Name");
      }else if(subTitle.value.text == ""){
        showCustomSnackBar("SubTitle is Empty",title: "Error Subtitle");
      }else if(price.value.text == ""){
        showCustomSnackBar("price is Empty",title: "Error price");
      }else if(description.value.text == ""){
        showCustomSnackBar("description is Empty",title: "Error description");
      }
      else if(listColor.isEmpty){
        showCustomSnackBar("Color is Empty",title: "Error Color");
      }else if(listSize.isEmpty){
        showCustomSnackBar("Size is Empty",title: "Error Size");
      }
      else{
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              dialogContext = context;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  BigText(text: "Đang up load"),
                ],
              );
            });

      await shoesController.updateProduct(shoesController.shoesProductList[widget.index].id.toString(), mapPostData).then((status){
        if(status.isSuccess){
          Navigator.pop(dialogContext);
          showCustomSnackBar("Update Product Success",isError: false);
          Get.find<ShoesController>().shoesProductList;
        }else{
          Navigator.pop(dialogContext);
          showCustomSnackBar("Error Update: "+ status.message,);
        }
      });
      }
    }



    return GetBuilder<ShoesController>(builder: (shoesController) {
      listImgApiBase = shoesController.shoesProductList[widget.index].listimg!;
      listImgApi = listImgApiBase.substring(0,listImgApiBase.length - 1);
      listImg = convertDataStringToList(listImgApi);
      return Container(
        decoration: const BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SingleChildScrollView(
          controller: widget.controller,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return makeDismissible(
                                        context: context,
                                        child: DraggableScrollableSheet(
                                            maxChildSize: 0.8,
                                            minChildSize: 0.1,
                                            initialChildSize: 0.5,
                                            builder: (context, _controller) {
                                              return EditImageProduct(
                                                controller: _controller,
                                                shoesProduct:
                                                    widget.shoesProduct,
                                                index: widget.index,
                                              );
                                            }));
                                  });
                            },
                            child: SizedBox(
                              height: Dimensions.height20 * 10,
                              width: Dimensions.width20 * 10,
                              child: PageView.builder(
                                  controller: pageController,
                                  itemCount:
                                      listImg.isNotEmpty ? listImg.length : 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          right: Dimensions.height5),
                                      decoration: BoxDecoration(
                                          color: AppColors.greenColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.radius10)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(listImg
                                                    .isNotEmpty
                                                ? AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    "shoes/" +
                                                    listImg[index]
                                                : AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    "shoes/" +
                                                    "no_image.png"),
                                          )),
                                    );
                                  }),
                            ),
                          ),
                          buildDotsIndicator(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: widget.onTapEditText,
                            child: ButtonBorderRadius(
                                widget: Container(
                                    alignment: Alignment.center,
                                    child: BigText(
                                      text: "Edit Product",
                                      color: AppColors.mainColor,
                                    ))),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          GestureDetector(
                            onTap: () {
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
                                        content: Text("You want delete it!"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                deleteProduct(productsModel.id!);
                                              },
                                              child: Text("Delete")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel")),
                                        ],
                                      ));
                            },
                            child: ButtonBorderRadius(
                                widget: Container(
                                    alignment: Alignment.center,
                                    child: BigText(
                                      text: "Delete Product",
                                      color: AppColors.mainColor,
                                    ))),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ButtonBorderRadius(
                                widget: Container(
                                    alignment: Alignment.center,
                                    child: BigText(
                                      text: "Cancel",
                                      color: AppColors.mainColor,
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: Column(
                  children: [
                    EditTextForm(controller: name, labelText: "Name"),
                    SizedBox(height: Dimensions.height10),
                    EditTextForm(
                        controller: subTitle,
                        minLines: 2,
                        labelText: "SubTitle"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    EditTextForm(
                        controller: price,
                        textInputType: TextInputType.number,
                        labelText: "Price"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    EditTextForm(
                      controller: description,
                      minLines: 6,
                      labelText: "Description",
                      radiusBorder: Dimensions.radius20,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Select Type",
                        labelStyle: TextStyle(
                          fontSize: Dimensions.font22,
                          fontWeight: FontWeight.bold,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          borderSide: BorderSide(
                            color: AppColors.paraColor,
                            width: 3,
                          ),
                        ),
                      ),
                      value: _selectedType,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                         shoesTypeListModel.forEach((element) {
                           if(element.name == newValue){
                             _selectedTypeInt = element.id;
                           }
                         });
                         print(_selectedTypeInt);
                        });
                      },
                      items: shoesTypeList.map((item) {
                        return DropdownMenuItem(
                          child: BigText(
                            text: item.replaceAll('"', ""),
                            color: Colors.black,
                          ),
                          value: item,
                        );
                      }).toList(),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        BigText(
                          text: "Color: ",
                          color: Colors.black,
                          fontSize: Dimensions.font22,
                        ),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        for (int i = 0; i < listColor.length; i++)
                          Stack(
                            children: [
                              Icon(Icons.circle,
                                  size: Dimensions.iconSize26 * 2,
                                  color: Color(int.parse(listColor[i]))),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      listColor.removeAt(i);
                                      setState(() {

                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      minRadius: 10,
                                      child: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: Dimensions.font16 * 1.5,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Pick Your Color'),
                                    content: Column(
                                      children: [
                                        buildColorPicker(),
                                        TextButton(
                                          child: BigText(
                                            text: "SELECT",
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            String colorString = color
                                                .toString(); // Color(0x12345678)
                                            String valueColor = colorString
                                                .split('(')[1]
                                                .split(')')[0];
                                            if (checkWasValue(
                                                listColor, valueColor)) {
                                              showCustomSnackBar(
                                                  "Error: color already exists");
                                            } else {
                                              listColor.add(valueColor);
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: Dimensions.height40,
                            width: Dimensions.height40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: Colors.white),
                            child: Icon(
                              Icons.add_outlined,
                              color: AppColors.mainColor,
                              size: Dimensions.font26 * 1.5,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        BigText(
                          text: "Size: ",
                          color: Colors.black,
                          fontSize: Dimensions.font22,
                        ),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        for (int i = 0; i < listSize.length; i++)
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Dimensions.width5,
                                    top: Dimensions.height5),
                                child: Container(
                                  height: Dimensions.height50,
                                  width: Dimensions.width50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.textColor,
                                          spreadRadius: 1,
                                          offset: Offset(0, 0),
                                          blurRadius: 2,
                                        )
                                      ],
                                      border: Border.all(
                                        color: AppColors.textColor,
                                        width: 1,
                                      )),
                                  child: Center(
                                    child: BigText(
                                      text: listSize[i].toString(),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font20,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      listSize.removeAt(i);
                                      setState(() {

                                      });
                                      print(listSize);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      minRadius: 10,
                                      child: Icon(
                                        Icons.highlight_remove,
                                        color: Colors.red,
                                        size: Dimensions.font16 * 1.5,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context,setStateDialog) {
                                      return Center(
                                        child: SizedBox(
                                          height: Dimensions.height50 * 10,
                                          child: AlertDialog(
                                            title: Text('Pick Your Size'),
                                            content: Column(
                                              children: [
                                                buildSizePicker(setStateDialog),
                                                Row(
                                                  children: [
                                                    BigText(
                                                      text: "Add: ",
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.height10,
                                                    ),
                                                    BigText(
                                                        text: "Size " +
                                                            sizeIndexPicker),
                                                  ],
                                                ),
                                                TextButton(
                                                  child: BigText(
                                                    text: "SELECT",
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    if (checkWasValue(listSize,
                                                        sizeIndexPicker)) {
                                                      showCustomSnackBar(
                                                          "Error: Size already exists");
                                                    } else {
                                                      listSize.add(sizeIndexPicker);
                                                      setState(() {});
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                });
                          },
                          child: Container(
                            height: Dimensions.height40,
                            width: Dimensions.height40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: Colors.white),
                            child: Icon(
                              Icons.add_outlined,
                              color: AppColors.mainColor,
                              size: Dimensions.font26 * 1.5,
                            ),
                          ),
                        )
                      ],
                    ),
                    SwitchListTile(
                        title: BigText(
                          text: "Released",
                          color: AppColors.blackColor,
                        ),
                        value: releasedProduct,
                        onChanged: (bool value) {
                          setState(() {
                            releasedProduct = value;
                          });
                        }),
                    GestureDetector(
                        onTap: () {
                          updateProduct(shoesController);
                        },
                        child: ButtonBorderRadius(
                            widget: BigText(
                          text: "Save",
                        ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  buildSizePicker(void Function(void Function()) setStateDialog) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          setStateDialog(() {
            sizeIndexPicker = pickItemsSize[index];
          });
        },
        children: pickItemsSize
            .map((item) => Center(
          child: BigText(
            text: item,
          ),
        ))
            .toList(),
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

  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: listImg.isEmpty ? 1 : listImg.length,
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

  buildColorPicker() {
    return ColorPicker(
        pickerColor: color,
        onColorChanged: (color) {
          this.color = color;
        });
  }

  bool checkWasValue(List<String> listString, String valueString) {
    final index = listString.indexOf(valueString);
    if (index == -1) {
      return false;
    }
    return true;
  }
}
