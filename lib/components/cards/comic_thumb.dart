import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class ComicThumb extends StatelessWidget {
  const ComicThumb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.card,
      width: 100,
      height: double.infinity,
      child: HeroIcon(
        HeroIcons.bookOpen,
        style: HeroIconStyle.solid,
        color: Palette.comic_icon,
      )
    );
  }
}