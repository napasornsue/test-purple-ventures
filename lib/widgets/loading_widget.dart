import 'package:flutter/material.dart';
import 'package:test_purple_ventures/widgets/linear_gradient_widget.dart';

class LoadingWidget extends StatelessWidget {
  double? opacity;

  LoadingWidget({
    Key? key,
    this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return LinearGradientWidget(
      opacity: opacity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: screenHeight / 2),
            child: SizedBox(
              width: 145.99,
              height: 43.1,
              // child: Image.asset("assets/images/loading_ic.webp"),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
