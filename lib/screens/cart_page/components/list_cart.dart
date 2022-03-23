import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import 'cart_item.dart';

class ListCart extends StatelessWidget {
  const ListCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: List.generate(
          5,
              (index) =>
              GestureDetector(
                  onTap: () {
                  },
                  child: CartItem(),
        ),
      ),
    ));
  }
}
