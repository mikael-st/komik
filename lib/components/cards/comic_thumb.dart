import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class ComicThumb extends StatelessWidget {
  final double? height;
  const ComicThumb({
    super.key,
    this.height = 126
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.card,
      width: 100,
      height: height,
      child: HeroIcon(
        HeroIcons.bookOpen,
        style: HeroIconStyle.solid,
        color: Palette.comic_icon,
      )
    );
  }
}