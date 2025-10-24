import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Theme Colors
const Color _primaryLight = Color(0xFF745B0C);
const Color _onPrimaryLight = Color(0xFFFFFFFF);
const Color _primaryContainerLight = Color(0xFFFFE08F);
const Color _onPrimaryContainerLight = Color(0xFF241A00);

const Color _secondaryLight = Color(0xFF695D3F);
const Color _onSecondaryLight = Color(0xFFFFFFFF);
const Color _secondaryContainerLight = Color(0xFFF2E1BB);
const Color _onSecondaryContainerLight = Color(0xFF231B04);

const Color _tertiaryLight = Color(0xFF47664A);
const Color _onTertiaryLight = Color(0xFFFFFFFF);
const Color _tertiaryContainerLight = Color(0xFFC9ECC8);
const Color _onTertiaryContainerLight = Color(0xFF04210B);

const Color _errorLight = Color(0xFFBA1A1A);
const Color _onErrorLight = Color(0xFFFFFFFF);
const Color _errorContainerLight = Color(0xFFFFDAD6);
const Color _onErrorContainerLight = Color(0xFF410002);

const Color _surfaceLight = Color(0xFFFFF8F1);
const Color _onSurfaceLight = Color(0xFF1F1B13);

const Color _surfaceVariantLight = Color(0xFFECE1CF);
const Color _onSurfaceVariantLight = Color(0xFF4C4639);
const Color _outlineLight = Color(0xFF7E7667);
const Color _outlineVariantLight = Color(0xFFCFC5B4);

const Color _inverseSurfaceLight = Color(0xFF343027);
const Color _inverseOnSurfaceLight = Color(0xFFF9F0E2);
const Color _inversePrimaryLight = Color(0xFFE4C36C);

// Dark Theme Colors
const Color _primaryDark = Color(0xFFE4C36C);
const Color _onPrimaryDark = Color(0xFF3D2E00);
const Color _primaryContainerDark = Color(0xFF584400);
const Color _onPrimaryContainerDark = Color(0xFFFFE08F);

const Color _secondaryDark = Color(0xFFD5C5A0);
const Color _onSecondaryDark = Color(0xFF392F15);
const Color _secondaryContainerDark = Color(0xFF51462A);
const Color _onSecondaryContainerDark = Color(0xFFF2E1BB);

const Color _tertiaryDark = Color(0xFFADCFAD);
const Color _onTertiaryDark = Color(0xFF1A361E);
const Color _tertiaryContainerDark = Color(0xFF304D33);
const Color _onTertiaryContainerDark = Color(0xFFC9ECC8);

const Color _errorDark = Color(0xFFFFB4AB);
const Color _onErrorDark = Color(0xFF690005);
const Color _errorContainerDark = Color(0xFF93000A);
const Color _onErrorContainerDark = Color(0xFFFFDAD6);

const Color _surfaceDark = Color(0xFF16130B);
const Color _onSurfaceDark = Color(0xFFEAE1D4);

const Color _surfaceVariantDark = Color(0xFF4C4639);
const Color _onSurfaceVariantDark = Color(0xFFCFC5B4);
const Color _outlineDark = Color(0xFF989080);
const Color _outlineVariantDark = Color(0xFF4C4639);

const Color _inverseSurfaceDark = Color(0xFFEAE1D4);
const Color _inverseOnSurfaceDark = Color(0xFF343027);
const Color _inversePrimaryDark = Color(0xFF745B0C);

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _primaryLight,
      onPrimary: _onPrimaryLight,
      primaryContainer: _primaryContainerLight,
      onPrimaryContainer: _onPrimaryContainerLight,
      secondary: _secondaryLight,
      onSecondary: _onSecondaryLight,
      secondaryContainer: _secondaryContainerLight,
      onSecondaryContainer: _onSecondaryContainerLight,
      tertiary: _tertiaryLight,
      onTertiary: _onTertiaryLight,
      tertiaryContainer: _tertiaryContainerLight,
      onTertiaryContainer: _onTertiaryContainerLight,
      error: _errorLight,
      onError: _onErrorLight,
      errorContainer: _errorContainerLight,
      onErrorContainer: _onErrorContainerLight,
      surface: _surfaceLight,
      onSurface: _onSurfaceLight,
      surfaceContainerHighest: _surfaceVariantLight,
      onSurfaceVariant: _onSurfaceVariantLight,
      outline: _outlineLight,
      outlineVariant: _outlineVariantLight,
      inverseSurface: _inverseSurfaceLight,
      onInverseSurface: _inverseOnSurfaceLight,
      inversePrimary: _inversePrimaryLight,
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: _primaryLight,
      foregroundColor: _onPrimaryLight,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: _onPrimaryLight,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _primaryLight,
      inactiveTrackColor: _outlineVariantLight,
      thumbColor: _primaryLight,
      overlayColor: _primaryLight.withValues(alpha: 0.12),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _primaryDark,
      onPrimary: _onPrimaryDark,
      primaryContainer: _primaryContainerDark,
      onPrimaryContainer: _onPrimaryContainerDark,
      secondary: _secondaryDark,
      onSecondary: _onSecondaryDark,
      secondaryContainer: _secondaryContainerDark,
      onSecondaryContainer: _onSecondaryContainerDark,
      tertiary: _tertiaryDark,
      onTertiary: _onTertiaryDark,
      tertiaryContainer: _tertiaryContainerDark,
      onTertiaryContainer: _onTertiaryContainerDark,
      error: _errorDark,
      onError: _onErrorDark,
      errorContainer: _errorContainerDark,
      onErrorContainer: _onErrorContainerDark,
      surface: _surfaceDark,
      onSurface: _onSurfaceDark,
      surfaceContainerHighest: _surfaceVariantDark,
      onSurfaceVariant: _onSurfaceVariantDark,
      outline: _outlineDark,
      outlineVariant: _outlineVariantDark,
      inverseSurface: _inverseSurfaceDark,
      onInverseSurface: _inverseOnSurfaceDark,
      inversePrimary: _inversePrimaryDark,
    ),
    textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: _surfaceDark,
      foregroundColor: _onSurfaceDark,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: _onSurfaceDark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _primaryDark,
      inactiveTrackColor: _outlineVariantDark,
      thumbColor: _primaryDark,
      overlayColor: _primaryDark.withValues(alpha: 0.12),
    ),
  );
}
