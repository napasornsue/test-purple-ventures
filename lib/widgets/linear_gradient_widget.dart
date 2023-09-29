import 'package:flutter/material.dart';
import 'package:test_purple_ventures/values/app_color.dart';

class LinearGradientWidget extends StatefulWidget {
  Widget child;
  double? opacity;

  LinearGradientWidget({
    Key? key,
    required this.child,
    this.opacity
  }) : super(key: key);

  @override
  State<LinearGradientWidget> createState() => _LinearGradientWidgetState();
}

class _LinearGradientWidgetState extends State<LinearGradientWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              // AppColor.lightGrey.withOpacity(widget.opacity ?? 1),
              AppColor.black.withOpacity(widget.opacity ?? 1),
            ],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
