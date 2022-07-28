import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants{
   static final firstElementPadding = EdgeInsets.fromLTRB(8, 12, 8, 8);
   static final cardPadding = EdgeInsets.all(8);
   static final formPadding = EdgeInsets.symmetric(horizontal: 8);
   static final rightArrow = Icon(Icons.arrow_forward_ios_rounded,color: Constants.appColor,size: 32);
   static final outlineBorderforFORM = OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)));
   static final appColor = Colors.teal;
   static final fillColor = Constants.appColor.shade100;
   static final TextStyle pageHeader = GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white
   );static final TextStyle addedExpensesStyle = GoogleFonts.quicksand(
      fontWeight: FontWeight.bold,
      fontSize: 28,
   );


}