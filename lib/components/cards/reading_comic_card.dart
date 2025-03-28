import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';

class ReadingComicCard extends StatelessWidget {
  final double width;

  final String    title;
  final String    edition;
  final int       actualPage;
  final int       totalPages;

  const ReadingComicCard({
    super.key,
    this.width = 332,
    required this.title,
    required this.edition,
    required this.actualPage,
    required this.totalPages
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/reader'),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Palette.items,
        ),
        height: 145,
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Row (
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        ComicThumb(
          height: double.infinity,
          thumb: MemoryImage(Uint8List(0)),
        ),
        _title(),
        OptionsBtn()
      ],
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column (
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: KomikTypography.card_title),
          _subtitles()
        ],
      )
    )
    );
  }

  Widget _subtitles() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edição $edition', style: KomikTypography.subtitles),
          Text('$actualPage / $totalPages páginas', style: KomikTypography.subtitles)
        ],
      )
    );
  }
}
