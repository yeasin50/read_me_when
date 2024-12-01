import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme(TextTheme textTheme) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF54B684),
      scaffoldBackgroundColor: const Color(0xFFF9F5EB),
      cardColor: const Color(0xFFFEFBEA),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFF9F5EB),
        elevation: 4.0,
        selectedItemColor: Color(0xFF54B684),
        unselectedItemColor: Color(0xFF9DA3B4),
      ),
      textTheme: textTheme.copyWith(
        titleLarge: GoogleFonts.amiri(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2E4730), // Deep Green
        ),
        bodyLarge: GoogleFonts.lora(
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          color: const Color(0xFF464E4D), // Slate Gray for body text
        ),
        bodyMedium: GoogleFonts.lora(
          fontSize: 16.0,
          color: const Color(0xFF9DA3B4), // Cool Gray for secondary body text
        ),
      ),

      // Button Themes
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF54B684), // Text button text color
          backgroundColor: Colors.transparent, // Transparent for minimalism
          textStyle: GoogleFonts.lora(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // White text on primary buttons
          backgroundColor: const Color(0xFF54B684), // Soft Emerald
          textStyle: GoogleFonts.lora(fontSize: 16.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),

      // Icon Button Themes
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: const Color(0xFF54B684), // Icon color
          backgroundColor: Colors.transparent, // No background for icon buttons
          iconSize: 24.0,
        ),
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        color: const Color(0xFF54B684), // Soft Emerald
        elevation: 2.0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.amiri(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // Text Selection Theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFF54B684), // Cursor color
        selectionColor: Color(0xFFAFE1D2), // Highlighted text background
        selectionHandleColor: Color(0xFF54B684), // Handle color
      ),
    );
  }
}
