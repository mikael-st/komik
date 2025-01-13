import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/tool-bars/reader_tool_bar.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReaderToolBar(),
      body: _content(),
    );
  }

  Widget _content() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _reader(),
          _pages()
        ],
      ),
    );
  }

  Widget _reader() {
    return Container(
      height: 552,
      width: double.infinity,
      color: Palette.card,
      child: HeroIcon(
        HeroIcons.bookOpen,
        style: HeroIconStyle.solid,
        color: Palette.comic_icon,
        size: 72,
      ),
    );
  }

  Widget _pages() {
    return Text('00 de 00 páginas', style: KomikTypography.action_button);
  }
}