import 'package:flutter/material.dart';

import '../../../components/big_text.dart';
import '../../../models/messages.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class MessagesCart extends StatelessWidget {
  const MessagesCart({
    Key? key, required this.messagesModel, required this.userId,
  }) : super(key: key);

  final MessagesModel messagesModel;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
      child: Row(
        mainAxisAlignment: messagesModel.idSend == userId?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: messagesModel.idSend == userId?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              messagesModel.messaging!= ""?Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.height20,
                      vertical: Dimensions.height10
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20 / 1.5),
                  ),
                  child: BigText(text: messagesModel.messaging!,color: Colors.black,)):Container(),
              SizedBox(height: Dimensions.height10,),
              messagesModel.image != ""?Container(
                height: Dimensions.height50*3,
                width: Dimensions.height50*3,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius10),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          messagesModel.image!),
                      fit: BoxFit.cover),
                ),
              ):Container(),

            ],
          ),
        ],
      ),
    );
  }
}
