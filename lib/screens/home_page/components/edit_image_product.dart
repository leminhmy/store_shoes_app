import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/base/show_custom_snackbar.dart';
import '../../../components/big_text.dart';
import '../../../components/button_border_radius.dart';
import '../../../components/icon_background_border_radius.dart';
import '../../../controller/shoes_controller.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class EditImageProduct extends StatefulWidget {
  const EditImageProduct({Key? key, required this.controller,required this.index, required this.shoesProduct}) : super(key: key);

  final ScrollController controller;
  final int index;
  final List<dynamic> shoesProduct;


  @override
  State<EditImageProduct> createState() => _EditImageProductState();

}

class _EditImageProductState extends State<EditImageProduct> {
  final ImagePicker _picker = ImagePicker();
   List<String> listImgApi = [];
  String listImgApiBase = '';
  List<XFile>? _imageList = [];
  String imgApiString = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listImgApiBase = Get.find<ShoesController>().shoesProductList[widget.index].listimg!;
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<ShoesController>(
        builder: (shoesController) {
          listImgApiBase = shoesController.shoesProductList[widget.index].listimg!;
          imgApiString = listImgApiBase.substring(0,listImgApiBase.length - 1);
          listImgApi = convertDataStringToList(imgApiString);
          print(listImgApi);
          return Container(
            decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20), topLeft: Radius.circular(20))),
            child: SingleChildScrollView(
              controller: widget.controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    children: [
                      for(int i = 0; i < listImgApi.length; i++)
                        listImgApi.isNotEmpty?Padding(
                          padding: EdgeInsets.all(Dimensions.height5),
                          child: Container(
                            height: Dimensions.height20*5,
                            width: Dimensions.height20*6,
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius10)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL+"shoes/"+
                                        listImgApi[i]),
                                )),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: IconBackgroundBorderRadius(
                                        sizeHeight: Dimensions.height30,
                                        icon: Icons.delete_forever,iconColor: AppColors.redColor,
                                        press: (){

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
                                                      onPressed: () async{
                                                        await shoesController.deleteImg(widget.shoesProduct[widget.index].id,listImgApi[i].toString()).then((status){
                                                          if(status.isSuccess)
                                                          {
                                                            showCustomSnackBar("Update Img Success",isError: false);
                                                            listImgApi.removeAt(i);
                                                            shoesController.getShoesProductList();
                                                            setState(() {

                                                            });
                                                          }
                                                          else{
                                                            print("Error" + status.message);
                                                            showCustomSnackBar("Error delete Img",);
                                                          }

                                                        });
                                                        Navigator.pop(context);

                                                      },
                                                      child: Text("Delete")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel")),
                                                ],
                                              ));


                                    })),
                              ],
                            ),
                          ),
                        ):Container(),
                      for(int i = 0; i < _imageList!.length; i++)
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height5),
                          child: Container(
                            height: Dimensions.height20*5,
                            width: Dimensions.height20*6,
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius10)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(_imageList![i].path))
                                )),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: IconBackgroundBorderRadius(
                                        sizeHeight: Dimensions.height30,
                                        icon: Icons.delete_forever,iconColor: AppColors.redColor, press: (){
                                      _imageList!.removeAt(i);
                                      setState(() {

                                      });
                                    })),
                              ],
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: (){
                          imageSelect();
                        },

                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height5),
                          child: Container(
                            height: Dimensions.height20*5,
                            width: Dimensions.height20*6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.radius10)),
                            ),
                            child: Center(child: Icon(Icons.add_outlined,size: Dimensions.font26*3,color: Colors.black),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: ()async{
                                  await uploadFileImg(widget.shoesProduct[widget.index].id);
                                  print("taped");
                                },
                                child: ButtonBorderRadius(widget: BigText(text: "Save",))),
                            GestureDetector(
                                onTap: ()async{
                                  await shoesController.getShoesProductList();
                                },
                                child: ButtonBorderRadius(widget: BigText(text: "Update",))),

                          ],
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
  }

  List<String> convertDataStringToList(String dataString) {
    List<String> listData = [];
    listData = (dataString.split(','));
    return listData;
  }

  void imageSelect()async{
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    if(selectedImage!.isNotEmpty){
      _imageList!.addAll(selectedImage);
    }
    print(selectedImage.length.toString());
    setState(() {
    });
  }

  uploadFileImg(int index) async {
    var postUri = Uri.parse(AppConstants.BASE_URL+AppConstants.UPLOAD_FILE_URI);
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    List<http.MultipartFile> listMultipartFile = [];
    for(int i = 0; i<_imageList!.length;i++){
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'image[]', _imageList![i].path,filename: basename(_imageList![i].path));

      listMultipartFile.add(multipartFile);
    }
    request.fields['id'] = index.toString();
    request.files.addAll(listMultipartFile);

    http.StreamedResponse response = await request.send();
    if(response.statusCode == 200)
    {
      _imageList = [];
      Get.find<ShoesController>().getShoesProductList();
      showCustomSnackBar("Upload Img Success",isError: false);
    }
    else{
      showCustomSnackBar("Error Upload Img Success",);
    }
    setState(() {

    });
    print(response.statusCode);

  }

/*//Error can't upload img with getx
    uploadFileImageGetx(ShoesController shoesController)async {

    // List<int> imgConvertBytes = List<int>.from(await _imageList![0].readAsBytes());
      var bytes = await _imageList![0].readAsBytes();
    // for(int i =0;i<_imageList!.length;i++){
    //   imgConvertBytes.addAll(List<int>.from(await _imageList![i].readAsBytes()));
    // }

      String fileName = basename(_imageList![0].path);

    FormData formData = FormData({
      'image': _imageList![0].path,
    });

    shoesController.uploadFile(formData).then((status){
      if(status.isSuccess){
        print("success upload");
      }else{
        showCustomSnackBar(status.message);
        print("Error status: "+ status.message.toString());
        // print(_imageList!.length);
        // print(imgConvertBytes);

      }
    });

  }*/
}
