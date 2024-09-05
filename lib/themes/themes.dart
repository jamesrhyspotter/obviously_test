import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  Themes._();

  static TextStyle mainFont = GoogleFonts.montserrat();

  static Color primaryPurple = const Color(0xffC0028B);
  static Color secondaryPurple = const Color(0xffF9E6F3);
  static Color buttonPurple = const Color(0xffDC7DC1);
  static Color primaryWhite = const Color(0xffF7F7F7);

  static Color black1 = const Color(0xff18191A);
  static Color black2 = const Color(0xff242526);
  static Color darkGrey = const Color(0xff3A3B3C);
  static Color lightGrey = const Color(0xffE4E6EB);
  static Color mediumGrey = const Color(0xffB0B3B8);

  static ThemeData mainTheme = ThemeData(
    primaryColor: primaryPurple,
    highlightColor: secondaryPurple,
    scaffoldBackgroundColor: primaryWhite,
    appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: primaryWhite),
        actionsIconTheme: IconThemeData(color: primaryWhite),
        backgroundColor: primaryPurple,
        titleTextStyle: mainFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        )),
    listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        minLeadingWidth: 10,
        iconColor: primaryWhite,
        tileColor: Colors.white,
        titleTextStyle: mainFont.copyWith(
          fontSize: 14, // Larger font size for the main amount
          fontWeight: FontWeight.bold,
          color: black1,
          letterSpacing: 0,
        )),
    iconTheme: IconThemeData(color: primaryWhite),
    textTheme: TextTheme(
      displayLarge: mainFont.copyWith(
          fontSize: 50, // Larger font size for the main amount
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
          color: primaryWhite),
      displayMedium: mainFont.copyWith(
          fontSize: 25, // Larger font size for the main amount
          fontWeight: FontWeight.bold,
          color: primaryWhite),
      displaySmall: mainFont.copyWith(
          fontSize: 20, // Larger font size for the main amount
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: primaryWhite),
      headlineLarge: mainFont.copyWith(
          fontSize: 24, // Larger font size for the main amount
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: darkGrey),
      headlineMedium: mainFont.copyWith(
          fontSize: 15, // Larger font size for the main amount
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: darkGrey),
      headlineSmall: mainFont.copyWith(
          fontSize: 10, color: mediumGrey, fontWeight: FontWeight.bold),
      labelLarge: mainFont.copyWith(
          fontSize: 20, // Larger font size for the main amount
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: primaryWhite),
    ),
    cardTheme: const CardTheme(
        color: Colors.white, shadowColor: Colors.black, elevation: 3),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: mainFont.copyWith(
            fontSize: 20, // Larger font size for the main amount
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
            color: primaryWhite),
        backgroundColor: buttonPurple,
        maximumSize: const Size(200.0, 40.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryWhite, width: 2.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryWhite, width: 2.0),
      ),
      hintStyle:
          mainFont.copyWith(color: primaryWhite), // Adjust hint text style
      labelStyle: mainFont.copyWith(color: primaryWhite), // Label text style
      filled: false, // No background fill for the TextField
    ),
  );
}
