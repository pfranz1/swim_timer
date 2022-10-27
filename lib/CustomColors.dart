import 'dart:ui';
import 'package:flutter/material.dart';

class CustomColors {
  static const Color freeStyle = Color(0xFF62CA50);
  static const Color backStroke = Color(0xFFD42A34);
  static const Color breastStroke = Color(0xFFF78C37);
  static const Color butterfly = Color(0xFF0677BA);

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFE6F3F9), Color(0xFFC6E3EE), Color(0xFFAAF6FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient backgroundGradient2 = LinearGradient(
    colors: [Color(0xFFC7EDFF), Color(0xFF62CFF9), Color(0xFFAAF6FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const bottomNavigationBar = Color(0xFF10465F);
}
