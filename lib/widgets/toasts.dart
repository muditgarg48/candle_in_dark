import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'package:flutter/material.dart';

Future<dynamic> toast(
        BuildContext context, String msg, IconData startI, IconData endI) =>
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
