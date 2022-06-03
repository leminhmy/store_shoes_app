import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:store_shoes_app/components/base/custom_loader.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/controller/messages_controller.dart';
import 'package:store_shoes_app/controller/notification_controller.dart';
import 'package:store_shoes_app/controller/user_controller.dart';
import 'package:store_shoes_app/models/user_model.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/cart_history_page/cart_history_page.dart';
import 'package:store_shoes_app/screens/messaging_page/messaging_page.dart';
import 'package:store_shoes_app/screens/notification_page/notification_page.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../components/search_widget.dart';
import '../../controller/auth_controller.dart';
import '../../models/messages.dart';
import '../../utils/app_contants.dart';
import '../../utils/time_ago.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String query = '';
  late ValueChanged<String> onChanged;
  List<UserModel>? listMessages = [];
  String isYour = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<AuthController>().userLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      //funtion affter your login

      Get.find<MessagesController>().getMessages();
      Get.find<MessagesController>().getMissMessages();
      if (Get.find<UserController>().userModel!.status == 1) {
        Get.find<UserController>().getListAdmin();
        print("1");
      } else if (Get.find<UserController>().userModel!.status == 2) {
        Get.find<UserController>().getListUsers();
        print("2");
      }
      listMessages = Get.find<UserController>().listUsers;
      Get.find<NotificationController>().getNotification();
      setState(() {});
    }
  }

  void searchBook(String query) {
    final listMessages = Get.find<UserController>().listUsers.where((user) {
      final nameLower = user.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.listMessages = listMessages;
    });
  }

  timeWidget(int index) {
    MessagesModel messagesModel = Get.find<MessagesController>()
        .getLastMessPeople(listMessages![index].id!);

    var outputDate = DateTime.now().toString();
    DateTime parseDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(messagesModel.updatedAt!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
    outputDate = outputFormat.format(inputDate);

    return SmallText(text: TimeAgo.timeAgoSinceDate(parseDate));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      listMessages = userController.listUsers;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: "Chats",
                color: Colors.white,
                fontSize: Dimensions.font22,
              ),
              SearchWidget(
                widthWidget: Dimensions.height50 * 4,
                text: query,
                hintText: 'Search NameUser',
                onChanged: searchBook,
              ),
            ],
          ),
          actions: [
            GetBuilder<NotificationController>(
                builder: (notificationController) {
              return Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(NotificationPage(),
                            transition: Transition.cupertino);
                      },
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                      )),
                  notificationController.listNotification.isNotEmpty
                      ? Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            maxRadius: Dimensions.height10,
                            backgroundColor: Colors.red,
                            child: SmallText(
                                text: notificationController
                                    .listNotification.length
                                    .toString(),
                                color: Colors.white),
                          ),
                        )
                      : Positioned(right: 0, top: 0, child: Container()),
                ],
              );
            })
          ],
        ),
        body: Get.find<AuthController>().userLoggedIn()
            ? GetBuilder<MessagesController>(builder: (messagesController) {
                return listMessages!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.height20,
                            vertical: Dimensions.height10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: listMessages!.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if(messagesController.getLastMessPeople(listMessages![index].id!).idSend == Get.find<UserController>().userModel!.id!){
                                      isYour = 'Bạn: ';
                                    }else{
                                      isYour = '';
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            MessagingPage(
                                                userModel: listMessages![index],
                                                userTake:
                                                    listMessages![index].id!),
                                            transition: Transition.cupertino);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                listMessages![index].image == ""
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        minRadius: Dimensions
                                                                .height50 /
                                                            2,
                                                        backgroundImage:
                                                            AssetImage(
                                                          "assets/images/a2.png",
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        minRadius: Dimensions
                                                                .height50 /
                                                            2,
                                                        backgroundImage:
                                                            NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                "users/" +
                                                                listMessages![
                                                                        index]
                                                                    .image!),
                                                      ),
                                                Positioned(
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: Colors.green,
                                                      size:
                                                          Dimensions.iconSize16,
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Dimensions.height10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: listMessages![index]
                                                      .name!,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height5,
                                                ),
                                                messagesController
                                                            .getMissMessaging(
                                                                listMessages![
                                                                        index]
                                                                    .id!) >
                                                        0
                                                    ? BigText(
                                                        text: isYour+messagesController
                                                            .getLastMessPeople(
                                                                listMessages![
                                                                        index]
                                                                    .id!).messaging!,
                                                        color: Colors.black,
                                                      )
                                                    : SmallText(
                                                        text: isYour+messagesController
                                                            .getLastMessPeople(
                                                                listMessages![
                                                                        index]
                                                                    .id!).messaging!,
                                                        maxLines: 1,
                                                      ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                messagesController
                                                            .getMissMessaging(
                                                                listMessages![
                                                                        index]
                                                                    .id!) >
                                                        0
                                                    ? CircleAvatar(
                                                        maxRadius: 10,
                                                        backgroundColor:
                                                            Colors.red,
                                                        child: SmallText(
                                                          text: messagesController
                                                              .getMissMessaging(
                                                                  listMessages![
                                                                          index]
                                                                      .id!)
                                                              .toString(),
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : Container(),
                                                timeWidget(index),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    : const CustomLoader();
              })
            : choosseSignin(),
      );
    });
  }
}
