import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class ComicThumb extends StatelessWidget {
  final double? height;
  final MemoryImage thumb;
  
  const ComicThumb({
    super.key,
    required this.thumb,
    this.height = 126
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: height,
      decoration: thumb.bytes.isNotEmpty
          ? BoxDecoration(
            image: DecorationImage(image: thumb, fit: BoxFit.cover)
          )
          : BoxDecoration(color: Palette.card),
      child: thumb.bytes.isNotEmpty
        ? null
        : HeroIcon(
          HeroIcons.bookOpen,
          style: HeroIconStyle.solid,
          color: Palette.comic_icon,
        )
    );
  }
}