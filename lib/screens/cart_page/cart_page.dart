import 'package:flutter/material.dart';
import 'components/app_bar_action.dart';
import 'components/bottom_bar.dart';
import 'components/list_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Apbar
          AppBarAction(),
          //listCart
          ListCart(),
        ],
      ),
      bottomNavigationBar: BottomBarCart(),
    );
  }
}



