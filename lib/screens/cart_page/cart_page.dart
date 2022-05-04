import 'package:flutter/material.dart';
import 'components/app_bar_action.dart';
import 'components/bottom_bar.dart';
import 'components/list_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key, required this.page, required this.index}) : super(key: key);

  final String page;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Apbar
          AppBarAction(page: page,),
          //listCart
          ListCart(page: page,index: index),
        ],
      ),
      bottomNavigationBar: BottomBarCart(),
    );
  }
}



