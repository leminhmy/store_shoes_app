import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/base/app_variable.dart';
import '../../components/base/show_custom_snackbar.dart';
import '../../components/big_text.dart';
import '../../components/button_border_radius.dart';
import '../../components/edit_text_form.dart';
import '../../components/icon_background_border_radius.dart';
import '../../controller/shoes_controller.dart';
import '../../models/shoes_type.dart';
import '../../utils/app_contants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late TextEditingController name;
  late TextEditingController subTitle;
  late TextEditingController price;
  late TextEditingController description;

  //add color and size
  List<String> listColor = [];
  List<String> listSize = [];
  Color color = const Color(0xF8EA4545);

  //size
  String sizeIndexPicker = '';
  final pickItemsSize = [];

  //released
  bool releasedProduct = false;

  //shoes type
  List<String> shoesTypeList = [];
  List<ShoesTypeModel> shoesTypeListModel = [];
  String? _selectedType;
  int? _selectedTypeInt;

  //import image
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageList = [];
  XFile? _imageThumbnail;
  List<XFile>? _imageListRequest = [];
  //page  controller
  double _currPageValue = 0;
  PageController pageController = PageController(viewportFraction: 0.89);

  //check postdata
  late BuildContext dialogContext;
  @override
  void initState() {
    // TODO: implement initState

    pageController.addListener(() {
      _currPageValue = pageController.page!;
      setState(() {});
    });
    super.initState();
    name = TextEditingController(text: "name");
    subTitle = TextEditingController(text: "subTitle");
    price = TextEditingController(text: "0.0",);
    description = TextEditingController(text: "description");

    //size and color default
    pickItemsSize.addAll([
      for (int i = 20; i < 60; i++) "${i.toString()}",
    ]);
    sizeIndexPicker = pickItemsSize[0];

    //shoes type default
    shoesTypeListModel = Get.find<ShoesController>().shoesTypeList;
    shoesTypeListModel.forEach((element) {
      shoesTypeList.add(element.name!);
    });
    _selectedType = shoesTypeListModel[0].name;
    _selectedTypeInt = shoesTypeListModel[0].id;

    //imageString

  }

  uploadFileImg(BuildContext context) async {
    _imageListRequest = [];
    _imageListRequest = _imageList!;
    _imageListRequest!.add(_imageThumbnail!);

      if(_imageList!.isEmpty){
        showCustomSnackBar("List Image is Empty",title: "Error Image");
      }else if(_imageThumbnail == ''){
        showCustomSnackBar("Image thumbnail is Empty",title: "Error Image");
      }else if(listColor.isEmpty){
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


        var postUri = Uri.parse(AppConstants.BASE_URL+AppConstants.ADD_PRODUCT_URI);
        http.MultipartRequest request = http.MultipartRequest("POST", postUri);

        List<http.MultipartFile> listMultipartFile = [];
        for(int i = 0; i<_imageListRequest!.length;i++){
          http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
              'image[]', _imageListRequest![i].path,filename: basename(_imageListRequest![i].path));

          listMultipartFile.add(multipartFile);
        }
        request.files.addAll(listMultipartFile);
        request.fields['name'] = name.value.text;
        request.fields['sub_title'] = subTitle.value.text;
        request.fields['price'] = price.value.text;
        request.fields['description'] = description.value.text;
        request.fields['type_id'] = _selectedTypeInt.toString();
        request.fields['color'] = listColor.join(",");
        request.fields['size'] = listSize.join(",");
        request.fields['released'] = releasedProduct?"0":"1";

        http.StreamedResponse response = await request.send();
        if(response.statusCode == 200)
        {
          _imageList = [];
          _imageThumbnail = null;
          Get.find<ShoesController>().getShoesProductList();
          showCustomSnackBar("Upload Img Success",isError: false);
          Navigator.pop(dialogContext);
          setState(() {
          });

        }
        else{
          Navigator.pop(dialogContext);

          showCustomSnackBar("Error Upload Img Success",);
        }
        setState(() {

        });
        print(response.statusCode);
      }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: BigText(text: "ADD Product",fontSize: Dimensions.font26),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SingleChildScrollView(
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
                    SizedBox(
                      width: Dimensions.height10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: Dimensions.height10 * 12,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                image: _imageThumbnail == null
                                    ? DecorationImage(
                                        image: AssetImage(
                                            "assets/images/no_image.png"),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: FileImage(
                                            File(_imageThumbnail!.path)),
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          GestureDetector(
                            onTap: () {
                              imageSelect();
                            },
                            child: ButtonBorderRadius(
                                widget: Container(
                                    alignment: Alignment.center,
                                    child: BigText(
                                      text: "+ Image Thumbnail",
                                      color: AppColors.mainColor,
                                    ))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return buildAddMultiImageWidget(context);
                                  });
                            },
                            child: SizedBox(
                              height: Dimensions.height20 * 10,
                              child: PageView.builder(
                                  controller: pageController,
                                  itemCount: _imageList!.isNotEmpty
                                      ? _imageList!.length
                                      : 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          right: Dimensions.height5),
                                      decoration: BoxDecoration(
                                          color: AppColors.greenColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.radius10)),
                                          image: _imageList!.isNotEmpty
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(File(
                                                      _imageList![index].path)),
                                                )
                                              : const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "assets/images/no_image.png"),
                                                )),
                                    );
                                  }),
                            ),
                          ),
                          buildDotsIndicator(),
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
                            if (element.name == newValue) {
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
                                      setState(() {});
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
                                      setState(() {});
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
                           uploadFileImg(context);

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
      ),
    );
  }

  Widget buildAddMultiImageWidget(BuildContext context) {
    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
            maxChildSize: 0.8,
            minChildSize: 0.1,
            initialChildSize: 0.5,
            builder: (context, _controller) {
              return StatefulBuilder(
                builder: (context,setStateDialog) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            children: [
                              for (int i = 0; i < _imageList!.length; i++)
                                Padding(
                                  padding: EdgeInsets.all(Dimensions.height5),
                                  child: Container(
                                    height: Dimensions.height20 * 5,
                                    width: Dimensions.height20 * 6,
                                    decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.radius10)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(_imageList![i].path)))),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Positioned(
                                            right: 0,
                                            top: 0,
                                            child: IconBackgroundBorderRadius(
                                                sizeHeight: Dimensions.height30,
                                                icon: Icons.delete_forever,
                                                iconColor: AppColors.redColor,
                                                press: () {
                                                  _imageList!.removeAt(i);
                                                  setState(() {
                                                  });
                                                  setStateDialog(() {});
                                                })),
                                      ],
                                    ),
                                  ),
                                ),
                              GestureDetector(
                                onTap: () {
                                  imageSelectMulti(setStateDialog);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height5),
                                  child: Container(
                                    height: Dimensions.height20 * 5,
                                    width: Dimensions.height20 * 6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.radius10)),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add_outlined,
                                          size: Dimensions.font26 * 3,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
            }));
  }

  buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: _imageList!.isNotEmpty ? _imageList!.length : 1,
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

  buildSizePicker(void Function(void Function()) setStateDialog) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 50,
        onSelectedItemChanged: (index) {
          setStateDialog((){
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
    );;
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

  void imageSelectMulti(void Function(void Function()) setStateDialog) async {
    List<XFile>? selectedImage = [];
    selectedImage = await _picker.pickMultiImage();
    if (selectedImage!.isNotEmpty) {
      _imageList!.addAll(selectedImage);
    }
    print(selectedImage.length.toString());
    //imageString

    setStateDialog(() {});
    setState(() {});
  }

  void imageSelect() async {
    _imageThumbnail = null;
    _imageThumbnail = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
