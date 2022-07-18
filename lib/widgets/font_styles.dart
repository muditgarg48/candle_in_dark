import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle mainHeadingFont({TextStyle? fontDesign}) {
  return GoogleFonts.montserrat(textStyle: fontDesign);
}

TextStyle signButtonFont({TextStyle? fontDesign}) {
  return GoogleFonts.openSans(textStyle: fontDesign);
}

TextStyle elevatedButtonFont({TextStyle? fontDesign}) {
  return GoogleFonts.nunito(textStyle: fontDesign);
}