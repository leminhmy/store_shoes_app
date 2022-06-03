import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/controller/notification_controller.dart';
import 'package:store_shoes_app/models/notification_model.dart';
import 'package:store_shoes_app/utils/app_contants.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';
import 'package:store_shoes_app/utils/time_ago.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel>? listNotification = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listNotification = Get.find<NotificationController>().listNotification;


  }

   timeWidget(int index) {
    var outputDate = DateTime.now().toString();
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(listNotification![index].createdAt!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
    outputDate = outputFormat.format(inputDate);

    return SmallText(text: TimeAgo.timeAgoSinceDate(parseDate));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (notificationController) {
        listNotification = notificationController.listNotification;
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
             title:  BigText(text: "Notifications",fontSize: Dimensions.font22,color: Colors.black,),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){
                notificationController.getNotification();
              }, icon: Icon(Icons.message_outlined,color: Colors.grey,)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.height20),

                  child: ListView.builder(
                      itemCount:  listNotification!.length,
                      itemBuilder: (context, index){
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.5)),
                              )
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),

                                child: listNotification![index].image != ""?CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: AppColors.mainColor,
                                  backgroundImage: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+"users/"+listNotification![index].image!),
                                ):CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: AppColors.mainColor,
                                  backgroundImage: const AssetImage("assets/images/no_image.png"),
                                ),
                              ),
                              Expanded(child: Padding(
                                padding: EdgeInsets.only(right: Dimensions.height10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(text: listNotification![index].name!,fontWeight: FontWeight.bold,),
                                        timeWidget(index),
                                      ],
                                    ),
                                    SmallText(text: listNotification![index].title!),
                                    BigText(text: listNotification![index].body!,color: Colors.black,maxLines: 2,),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );

                      }),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
