import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color lightMint = Color(0xFFE8F5E9);
  static const Color textDark = Colors.black87;
  static const Color textGray = Colors.black38;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
