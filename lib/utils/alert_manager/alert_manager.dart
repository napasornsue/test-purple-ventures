import 'package:flutter/material.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';
import 'package:test_purple_ventures/values/app_string.dart';

class AlertManager {
  static AlertManager instance = AlertManager();

  AlertManager();

  presentConfirm({
    required BuildContext context,
    required String title,
    required String detail,
    String textOk = "OK",
    String textCancel = "Cancel",
    Function()? onPressOk,
    Function()? onPressCancel,
    bool isPop = true,
  }) {
    // set up the buttons
    Widget cancelButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.white,
        side: const BorderSide(width: 1, color: AppColor.blueSecond),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        textCancel,
        style: const TextStyle(
          color: AppColor.blueSecond,
          fontSize: 22,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressCancel != null) {
          onPressCancel();
        }
      },
    );

    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all(AppColor.blueSecond),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        textOk,
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 22,
          fontFamily: AppString.FONT_FAMILY_BOLD,
        ),
      ),
      onPressed: () {
        if (isPop) Navigator.of(context).pop();
        if (onPressOk != null) {
          onPressOk();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColor.blueSecond,
          fontSize: 20,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 29,
        child: Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.darkGrey,
            fontSize: 16,
            fontFamily: AppString.FONT_FAMILY_REGULAR
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 14),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: cancelButton,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.blueSecond,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  height: 40,
                  child: continueButton,
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: false,
    );
  }

  presentConfirmThreeChoice({
    required BuildContext context,
    required String title,
    required String detail,
    String textOk = "OK",
    String textChoice = "Cancel",
    String textCancel = "Cancel",
    Function()? onPressOk,
    Function()? onPressChoice,
    Function()? onPressCancel,
    bool isPop = true,
  }) {
    // set up the buttons
    Widget cancelButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.white,
        side: const BorderSide(width: 1, color: AppColor.blueSecond),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        textCancel,
        style: const TextStyle(
          color: AppColor.blueSecond,
          fontSize: 18,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressCancel != null) {
          onPressCancel();
        }
      },
    );

    // set up the buttons
    Widget choiceButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.white,
        side: const BorderSide(width: 1, color: AppColor.blueSecond),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        textChoice,
        style: const TextStyle(
          color: AppColor.blueSecond,
          fontSize: 18,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressChoice != null) {
          onPressChoice();
        }
      },
    );

    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all(AppColor.blueSecond),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        textOk,
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 18,
          fontFamily: AppString.FONT_FAMILY_BOLD,
        ),
      ),
      onPressed: () {
        if (isPop) Navigator.of(context).pop();
        if (onPressOk != null) {
          onPressOk();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColor.blueSecond,
          fontSize: 20,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 29,
        child: Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.darkGrey,
            fontSize: 16,
            fontFamily: AppString.FONT_FAMILY_REGULAR
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 14),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: cancelButton,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: choiceButton,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.blueSecond,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  height: 40,
                  child: continueButton,
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: false,
    );
  }

  presentConfirmRed({
    required BuildContext context,
    required String title,
    required String detail,
    String textOk = "OK",
    String textCancel = "Cancel",
    Function()? onPressOk,
    Function()? onPressCancel,
    bool isPop = true,
  }) {
    // set up the buttons
    Widget cancelButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.white,
        side: const BorderSide(width: 1, color: AppColor.error),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        textCancel,
        style: const TextStyle(
          color: AppColor.error,
          fontSize: 22,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressCancel != null) {
          onPressCancel();
        }
      },
    );

    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all(AppColor.error),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        textOk,
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 22,
          fontFamily: AppString.FONT_FAMILY_BOLD,
        ),
      ),
      onPressed: () {
        if (isPop) Navigator.of(context).pop();
        if (onPressOk != null) {
          onPressOk();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColor.error,
          fontSize: 20,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 29,
        child: Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.darkGrey,
            fontSize: 16,
            fontFamily: AppString.FONT_FAMILY_REGULAR
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 14),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: cancelButton,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.error,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  height: 40,
                  child: continueButton,
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: false,
    );
  }

  present({
    required BuildContext context,
    required String title,
    required String detail,
    String textOk = "OK",
    Function()? onPress,
    bool isCancelable = true,
  }) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all(AppColor.blueSecond),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        textOk,
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 22,
          fontFamily: AppString.FONT_FAMILY_BOLD,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPress != null) {
          onPress();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColor.blueSecond,
            fontSize: 20,
            fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 29,
        child: Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColor.darkGrey,
              fontSize: 16,
              fontFamily: AppString.FONT_FAMILY_REGULAR
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 14),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.blueSecond,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  height: 40,
                  child: continueButton,
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: isCancelable,
    );
  }

  presentError({
    required BuildContext context,
    required String title,
    required String detail,
    String textOk = "OK",
    Function()? onPress,
    bool isCancelable = true,
  }) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all(AppColor.error),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        textOk,
        style: const TextStyle(
          color: AppColor.white,
          fontSize: 22,
          fontFamily: AppString.FONT_FAMILY_BOLD,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPress != null) {
          onPress();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColor.error,
            fontSize: 20,
            fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 29,
        child: Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColor.darkGrey,
              fontSize: 16,
              fontFamily: AppString.FONT_FAMILY_REGULAR
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 14),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.error,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  height: 40,
                  child: continueButton,
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: isCancelable,
    );
  }

  presentActionSheet({
    required BuildContext context,
    required String title,
    required String detail,
    required List<Widget> buttons,
  }) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColor.blueSecond,
          fontSize: 20,
          fontFamily: AppString.FONT_FAMILY_BOLD
        ),
      ),
      content: Text(
        detail,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColor.darkGrey,
            fontSize: 16,
            fontFamily: AppString.FONT_FAMILY_REGULAR
        ),
      ),
      actions: [
        Column(
          children: buttons,
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showPopupError(BuildContext context, {String detail = "", Function()? onPress}) {
    AlertManager.instance.presentError(
        context: context,
        title: "Sorry",
        detail: detail.isEmpty ? "Something went wrong" : detail,
        textOk: "OK",
        isCancelable: false,
        onPress: () {
          if (onPress != null) {
            onPress();
          } else {
            AppDependency.instance.navigatorCoordinate.back(context);
          }
        }
    );
  }

}
