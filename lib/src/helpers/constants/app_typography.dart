import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A utility class that holds all the core [TextTheme] used
/// throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class AppTypography {
  const AppTypography._();

  /// Base TextTheme for the Poppins Font.
  static final _poppinsTextTheme = GoogleFonts.poppinsTextTheme();

  /// Base TextTheme for the Outfit Font.
  static final _outfitTextTheme = GoogleFonts.outfitTextTheme();

  /// The main [TextTheme] used for most of typography in the app.
  static final primary = _outfitTextTheme;

  /// The font family of the primary text theme.
  static final primaryFontFamily = primary.bodyLarge!.fontFamily;

  /// The secondary [TextTheme] used for lower level typography in the app.
  static final secondary = _poppinsTextTheme;

  /// The font family of the secondary text theme.
  static final secondaryFontFamily = secondary.bodyLarge!.fontFamily;
}
