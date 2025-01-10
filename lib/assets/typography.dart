import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class KomikTypography {
  static TextStyle get label => TextStyle(
    fontSize: 12,
    color: Palette.white,
    fontWeight: FontWeight.w600
  );

  static TextStyle get card_title => TextStyle(
    fontSize: 18,
    color: Palette.white,
  );

  static TextStyle get subtitles => TextStyle(
    fontSize: 12,
    color: Palette.subtitles,
  );
}