import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String image;
  const NoDataPage({Key? key, required this.text, this.image = "assets/images/empty_cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(image,
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width*0.22,
            fit: BoxFit.cover,
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03),
          Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height*0.0175,
              color: Theme.of(context).disabledColor
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
