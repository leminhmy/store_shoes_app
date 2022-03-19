import 'package:flutter/material.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../components/big_text.dart';
import '../../components/icon_and_text.dart';
import '../../components/small_text.dart';
import 'components/app_bar_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Dimensions.height30),
        child: Column(
          children: [
            AppBarHome(),
            SizedBox(height: Dimensions.height20,),
            SizedBox(
              height: Dimensions.pageView,
              child: PageView.builder(
                itemCount: 5,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(right: Dimensions.width30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            //imageBackground banner
                            GestureDetector(
                              onTap: (){
                                // Get.toNamed(RouteHelper.getPopularFood(index, "Home"));
                              },
                              child: Container(
                                height: Dimensions.pageViewContainer,
                                decoration: BoxDecoration(
                                    color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                                    image: DecorationImage(
                                        // image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!),
                                      image: AssetImage("assets/images/a2.jpg"),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(Dimensions.radius30))),
                              ),
                            ),

                            //information banner
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.all(Dimensions.width20),
                                padding: EdgeInsets.all(Dimensions.width15),
                                height: Dimensions.pageViewTextContainer,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.paraColor,
                                      blurRadius: 7,
                                      spreadRadius: -3,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(Dimensions.radius20)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: "Giay the thao",
                                      color: AppColors.mainBlackColor,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                              5,
                                                  (index) => Icon(
                                                Icons.star,
                                                color: AppColors.mainColor,
                                                size: Dimensions.iconSize16,
                                              )),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        SmallText(text: "4.5"),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        SmallText(text: "1287 comments"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndText(
                                          icon: Icons.circle,
                                          color: AppColors.iconColor1,
                                          text: "Normal",
                                        ),
                                        IconAndText(
                                          icon: Icons.location_on_rounded,
                                          color: AppColors.mainColor,
                                          text: "1.7km",
                                        ),
                                        IconAndText(
                                          icon: Icons.access_time_sharp,
                                          color: AppColors.iconColor2,
                                          text: "32min",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

