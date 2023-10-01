import 'package:flutter/material.dart';
import 'package:test_purple_ventures/values/app_color.dart';

class LoadingWidget extends StatelessWidget {

  LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColor.lightBlue,
      ),
    );
  }
}
