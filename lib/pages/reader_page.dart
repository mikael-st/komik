import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/tool-bars/reader_tool_bar.dart';

class ReaderPage extends StatefulWidget {
  final Function(String path) fetchPages;

  const ReaderPage({
    super.key,
    required this.fetchPages
  });

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  late List<Uint8List> pages;
  int actualPageIndex = 0;
  Uint8List actualPage = Uint8List(0);

  @override
  void initState() {
    super.initState();
    pages = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pages = widget.fetchPages(
      ModalRoute.of(context)?.settings.arguments as String
    );
    actualPage = pages[actualPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReaderToolBar(),
      body: _content(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pages = [];
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
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final touchX = details.localPosition.dx;
        
        if (touchX < width/2) {
          setState(() {
            actualPageIndex = actualPageIndex - 1;
            actualPage = pages[actualPageIndex];
          });
        } else {
          setState(() {
            actualPageIndex = actualPageIndex + 1;
            actualPage = pages[actualPageIndex];
          });
        }
      },
      child: Container(
        height: 552,
        width: width,
        decoration: actualPage.isNotEmpty
            ? BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(actualPage),
                fit: BoxFit.contain
              )
            )
            : BoxDecoration(
              color: Palette.card,
            ),
        child: actualPage.isNotEmpty
            ? null 
            : HeroIcon(
                HeroIcons.bookOpen,
                style: HeroIconStyle.solid,
                color: Palette.comic_icon,
                size: 72,
              ),
      ),
    );
  }

  Widget _pages() {
    return Text('00 de 00 páginas', style: KomikTypography.action_button);
  }
}