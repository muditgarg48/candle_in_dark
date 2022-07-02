import 'package:flutter/material.dart';

import '../tools/theme.dart';

Widget myButton({required Widget content, required dynamic action}) {
  return ElevatedButton(
    onPressed: action,
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      primary: themeButtonColor(),
      onPrimary: themeButtonTxtColor(),
      elevation: 15,
    ),
    child: content,
  );
}
