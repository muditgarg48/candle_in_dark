import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'package:flutter/material.dart';

Future<dynamic> toast(
        {required BuildContext context,required String msg,required IconData startI, IconData endI = Icons.check}) =>
    showQudsToast(
      context,
      content: Text(msg),
      toastTime: QudsToastTime.VeryShort,
      leadingActions: [
        QudsAutoAnimatedCombinedIcons(
          startIcon: startI,
          endIcon: endI,
          showStartIcon: true,
        ),
      ],
    );
