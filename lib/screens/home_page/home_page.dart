import 'package:flutter/material.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../components/big_text.dart';
import '../../components/icon_and_text.dart';
import '../../components/small_text.dart';
import 'components/app_bar_home.dart';
import 'components/category.dart';
import 'components/popular_product.dart';
import 'components/slider_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.height30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarHome(),
              SizedBox(
                height: Dimensions.height20,
              ),
              SliderBanner(),
              SizedBox(
                height: Dimensions.height10,
              ),
              Category(),
              SizedBox(
                height: Dimensions.height10,
              ),
              PopularProducts()
            ],
          ),
        ),
      ),
    );
  }
}

