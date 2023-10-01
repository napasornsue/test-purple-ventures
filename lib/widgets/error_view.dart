import 'package:flutter/material.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_string.dart';

class ErrorView extends StatefulWidget {
  String assetImage;
  String title;
  String detail;
  void Function()? onPressed;
  String? buttonTitle;

  ErrorView({
    Key? key,
    required this.assetImage,
    required this.title,
    required this.detail,
    this.onPressed,
    this.buttonTitle,
  }) : super(key: key);

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(widget.assetImage),
          width: 92,
          height: 92,
        ),
        const SizedBox(height: 24),
        Text(
          widget.title,
          style: const TextStyle(
            fontFamily: AppString.FONT_FAMILY_SEMI_BOLD,
            fontSize: 20,
            color: AppColor.darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          widget.detail,
          style: const TextStyle(
            fontFamily: AppString.FONT_FAMILY_REGULAR,
            fontSize: 16,
            color: AppColor.darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            widget.buttonTitle != null ?  Container(
              margin: const EdgeInsets.only(left: 47, right: 47),
              child: TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.only(top: 9, bottom: 9),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColor.error),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  widget.buttonTitle!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: AppString.FONT_FAMILY_SEMI_BOLD,
                    color: AppColor.error,
                  ),
                ),
                onPressed: () {
                  if (widget.onPressed != null) {
                    widget.onPressed!();
                  }
                },
              ),
            ) : Container(
              height: 40,
            ),
          ],
        ),
      ],
    );
  }
}
