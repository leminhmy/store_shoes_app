import 'package:flutter/material.dart';
import 'components/app_bar_action.dart';
import 'components/bottom_bar.dart';
import 'components/list_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.page, required this.index}) : super(key: key);

  final String page;
  final int index;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  String nameCart = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.page == "carthistory"){
      nameCart = "Cart History";
    }
    else{
      nameCart = "Cart Page";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Apbar
          AppBarAction(page: widget.page, nameCart: nameCart,),
          //listCart
          ListCart(page: widget.page,index: widget.index),
        ],
      ),
      bottomNavigationBar: BottomBarCart(page: widget.page, index: widget.index,),
    );
  }
}



