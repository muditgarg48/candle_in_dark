import 'package:flutter/material.dart';

import 'toasts.dart';

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
    return SizedBox();
  }

  Future clearBoard(BuildContext context) {
    jobDoneMsg();
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(confirmationMsg),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.clear,
              size: 25,
            ),
          ),
          IconButton(
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
            icon: const Icon(
              Icons.check,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
