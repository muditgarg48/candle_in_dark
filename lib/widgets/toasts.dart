import 'package:candle_in_dark/widgets/theme_data.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'package:flutter/material.dart';

Future<dynamic> toast({
  required BuildContext context,
  required String msg,
  required IconData startI,
  IconData endI = Icons.check,
}) =>
    showQudsToast(
      shadowColor: invertedThemeTxtColor(),
      backgroundColor: themeBgColor(),
      context,
      content: Text(
        msg,
        style: TextStyle(
          color: themeTxtColor(),
        ),
      ),
      toastTime: QudsToastTime.VeryShort,
      leadingActions: [
        QudsAutoAnimatedCombinedIcons(
          startIcon: startI,
          startIconColor: themeTxtColor(),
          endIcon: endI,
          endIconColor: themeTxtColor(),
          showStartIcon: true,
        ),
      ],
    );
