import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/screens/detail_page/components/orther_product.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../components/border_radius_widget.dart';
import 'components/bottom_bar_widget.dart';
import 'components/image_banner.dart';
import 'components/info_product.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageBanner(),
            SizedBox(
              height: Dimensions.height10,
            ),
            InfoProduct(),
            SizedBox(
              height: Dimensions.height15,
            ),
            OrtherProduct(),

          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}

