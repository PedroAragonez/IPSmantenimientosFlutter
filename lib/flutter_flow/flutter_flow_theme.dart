// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color background;
  Color darkBackground;
  Color textColor;
  Color grayDark;
  Color grayLight;

  TextStyle get title1 => GoogleFonts.getFont(
    'Lexend Deca',
    color: textColor,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  TextStyle get title2 => GoogleFonts.getFont(
    'Lexend Deca',
    color: primaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 28,
  );
  TextStyle get title3 => GoogleFonts.getFont(
    'Lexend Deca',
    color: textColor,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  TextStyle get subtitle1 => GoogleFonts.getFont(
    'Lexend Deca',
    color: grayLight,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  TextStyle get subtitle2 => GoogleFonts.getFont(
    'Lexend Deca',
    color: grayLight,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  TextStyle get bodyText1 => GoogleFonts.getFont(
    'Lexend Deca',
    color: grayLight,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
  TextStyle get bodyText2 => GoogleFonts.getFont(
    'Lexend Deca',
    color: textColor,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
}

class LightModeTheme extends FlutterFlowTheme {
  Color primaryColor = const Color(0xFFEF393C);
  Color secondaryColor = const Color(0xFFFB7C7C);
  Color tertiaryColor = const Color(0xFFFFE4E4);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color background = Color(0xFF1A1F24);
  Color darkBackground = Color(0xFF111417);
  Color textColor = Color(0xFFFFFFFF);
  Color grayDark = Color(0xFF57636C);
  Color grayLight = Color(0xFF8B97A2);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    TextDecoration decoration,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
        fontFamily,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
        decoration: decoration,
        height: lineHeight,
      )
          : copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        height: lineHeight,
      );
}