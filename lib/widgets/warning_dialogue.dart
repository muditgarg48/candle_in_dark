import 'package:flutter/material.dart';

import '../tools/theme.dart';

import './toasts.dart';

// ignore: must_be_immutable
class WarningDialogue extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  WarningDialogue({
    required this.confirmationMsg,
    required this.choice,
    required this.jobDone,
    required this.action,
  });

  late String confirmationMsg;
  late String choice;
  late IconData jobDone;
  late Function action;
  late String doneMsg = "";

  Widget titleHead = Text(
    "Warning!",
    style: TextStyle(
      color: themeTxtColor(),
    ),
  );

  Widget confirmation(String msg) {
    return Text(
      msg,
      style: TextStyle(
        color: themeTxtColor(),
      ),
    );
  }

  Widget noButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.clear,
        size: 25,
        color: invertedThemeTxtColor(),
      ),
    );
  }

  Widget yesButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        action(choice);
        toast(
          context: context,
          msg: doneMsg,
          startI: jobDone,
          endI: Icons.check,
        );
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.check,
        size: 25,
        color: invertedThemeTxtColor(),
      ),
    );
  }

  void jobDoneMsg() {
    if (choice == "values") {
      doneMsg = "Values cleared!";
    } else if (choice == "whole") {
      doneMsg = "Inputs and Selections cleared!";
    } else if (choice == "theme_change") {
      doneMsg = "Theme Toggled!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  Future dialogueBox(BuildContext context) {
    jobDoneMsg();
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: titleHead,
        backgroundColor: themeBgColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: confirmation(confirmationMsg),
        actions: [
          noButton(context),
          yesButton(context),
        ],
      ),
    );
  }
}
