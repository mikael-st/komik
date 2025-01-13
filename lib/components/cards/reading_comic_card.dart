import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/options_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';

class ReadingComicCard extends StatelessWidget {
  final double width;
  const ReadingComicCard({
    super.key,
    this.width = 332
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Palette.items,
      ),
      height: 145,
      child: _content(),
    );
  }

  Widget _content() {
    return Row (
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        ComicThumb(
          height: double.infinity,
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
          Text('Titulo', style: KomikTypography.card_title),
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
          Text('Edição 00', style: KomikTypography.subtitles),
          Text('00 / 00 páginas', style: KomikTypography.subtitles)
        ],
      )
    );
  }
}
