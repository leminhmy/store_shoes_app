import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/models/user_model.dart';

import '../../../components/base/show_custom_snackbar.dart';
import '../../../components/big_text.dart';
import '../../../components/button_border_radius.dart';
import '../../../components/edit_text_form.dart';
import '../../../controller/user_controller.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HeaderImageProfile extends StatefulWidget {
  const HeaderImageProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderImageProfile> createState() => _HeaderImageProfileState();
}

class _HeaderImageProfileState extends State<HeaderImageProfile> {
  late TextEditingController phone;
  late TextEditingController name;
  XFile? _imageAvatar;
  late BuildContext dialogContext;

  final ImagePicker _picker = ImagePicker();


  void imageSelectGallery(Function(void Function()) setStateDialog) async {
    _imageAvatar = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      setStateDialog((){

      });
    });
  }
  void imageSelectCamera(Function(void Function()) setStateDialog) async {
    _imageAvatar = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      setStateDialog((){

      });
    });
  }

  updateProfile(BuildContext context) async {

    if(name.value.text.isEmpty){
      showCustomSnackBar("Name is Empty",title: "Error Name");
    }else if(phone.value.text.isEmpty){
      showCustomSnackBar("Phone is Empty",title: "Error Phone");
    }else if(_imageAvatar == null){
      showCustomSnackBar("Avatar Empty",title: "Error avatar");
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

      var postUri = Uri.parse(AppConstants.BASE_URL+AppConstants.USER_UPDATE_URI);
      http.MultipartRequest request = http.MultipartRequest("POST", postUri);

        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'image', _imageAvatar!.path,filename: basename(_imageAvatar!.path));

      request.files.add(multipartFile);
      request.fields['name'] = name.value.text;
      request.fields['phone'] = phone.value.text;
      ApiClient apiClient = ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find());
      request.headers.addAll(apiClient.mainHeaders);

      http.StreamedResponse response = await request.send();
      if(response.statusCode == 200)
      {
        Get.find<UserController>().getUserInfo();
        showCustomSnackBar("Upload Img Success",isError: false);
        Navigator.pop(dialogContext);


      }
      else{
        Navigator.pop(dialogContext);

        showCustomSnackBar("Error Upload Img Success",);
      }

      print(response.statusCode);
    }


  }

  @override
  Widget build(BuildContext context) {


    return GetBuilder<UserController>(
      builder: (userController) {
        phone = TextEditingController(text: userController.userModel!.phone,);
        name = TextEditingController(text: userController.userModel!.name,);
        return Container(
            height: Dimensions.height50*4,
            padding: EdgeInsets.all(Dimensions.height10),
            width: double.maxFinite,
            child: Center(
              child: CircleAvatar(
                maxRadius: double.maxFinite,
                backgroundColor: AppColors.mainColor,
                backgroundImage: userController.userModel!.image! != ""?NetworkImage(AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +"users/"+
                    userController.userModel!.image!):const NetworkImage(AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +"users/"+
                    "no_image.png"),

                child: GestureDetector(
                  onTap: (){
                    print("taped");

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
                                  title: Text('Chỉnh Sửa Thông Tin'),
                                  content: SizedBox(
                                    height: Dimensions.height50 * 8,
                                    width: Dimensions.screenWidth * 0.9,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(onPressed: (){
                                              imageSelectGallery(setStateDialog);

                                            }, icon: Icon(Icons.image,size: Dimensions.iconSize26,color: AppColors.mainColor,)),
                                            _imageAvatar == null?CircleAvatar(
                                              maxRadius: Dimensions.height50*1.5,
                                              backgroundColor: AppColors.mainColor,
                                              backgroundImage: userController.userModel!.image!.isNotEmpty?NetworkImage(AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +"users/"+
                                                  userController.userModel!.image!):const NetworkImage(AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +"users/"+
                                                  "no_image.png"),
                                            ):CircleAvatar(
                                              maxRadius: Dimensions.height50*1.5,
                                              backgroundColor: AppColors.mainColor,
                                              backgroundImage: FileImage(
                                                File(_imageAvatar!.path)
                                              ),
                                            ),
                                            IconButton(onPressed: (){
                                              imageSelectCamera(setStateDialog);

                                            }, icon: Icon(Icons.camera_alt_outlined,size: Dimensions.iconSize26,color: AppColors.mainColor,)),
                                          ],
                                        ),
                                        EditTextForm(
                                            controller: name,
                                            labelText: "Name"),
                                        SizedBox(height: Dimensions.height10,),
                                        EditTextForm(
                                            controller: phone,
                                            textInputType: TextInputType.number,
                                            labelText: "Price"),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: (){
                                            updateProfile(context);
                                          },
                                          child: ButtonBorderRadius(
                                            widget: BigText(
                                              text: "Save",
                                              color: Colors.white,
                                            ),
                                            colorBackground: AppColors.mainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  },
                  child: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: AppColors.mainColor.withOpacity(0.2),
                    child: Icon(Icons.change_circle,size: Dimensions.height50,color: Colors.yellow.withOpacity(0.5),),
                  ),
                )
              ),
            ));
      }
    );
  }
}
