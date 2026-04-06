import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryBlue = Color(0xFF1565C0);
const kAccentBlue = Color(0xFF1E88E5);
const kLightBlue = Color(0xFFE3F2FD);
const kDarkBlue = Color(0xFF0D47A1);
const kHighRisk = Color(0xFFD32F2F);
const kMediumRisk = Color(0xFFF57C00);
const kLowRisk = Color(0xFF2E7D32);

ThemeData healthGuardTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryBlue),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF5F9FF),
  textTheme: GoogleFonts.poppinsTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryBlue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kPrimaryBlue,
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBBDEFB)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBBDEFB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
    ),
  ),
);