import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/tool-bars/reader_tool_bar.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';

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
  late List<MemoryImage> pages;
  late ComicReaderInfos infos;
  int actualPageIndex = 0;
  MemoryImage actualPage = MemoryImage(Uint8List(0));

  @override
  void initState() {
    super.initState();
    pages = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    infos = ModalRoute.of(context)?.settings.arguments as ComicReaderInfos;
    pages = widget.fetchPages(
      infos.path
    );
    actualPage = pages[actualPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReaderToolBar(
        title: infos.title,
      ),
      body: _content(),
    );
  }

  @override
  void dispose() {
    pages.clear();
    pages = [];
    actualPage = MemoryImage(Uint8List(0));
    actualPageIndex = 0;

    super.dispose();
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
            actualPageIndex--;
            actualPage = isNotFirstPage && isNotLastPage ? pages[actualPageIndex] : pages[actualPageIndex];
          });
        } else {
          setState(() {
            actualPageIndex++;
            actualPage = isNotFirstPage && isNotLastPage ? pages[actualPageIndex] : pages[actualPageIndex];
          });
        }
      },
      child: Container(
        height: 552,
        width: width,
        decoration: actualPage.bytes.isNotEmpty
            ? BoxDecoration(
              image: DecorationImage(
                image: actualPage,
                fit: BoxFit.contain
              )
            )
            : BoxDecoration(
              color: Palette.card,
            ),
        child: actualPage.bytes.isNotEmpty
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
    return Text('$actualPageIndex de ${pages.length} páginas', style: KomikTypography.action_button);
  }

  bool get isNotFirstPage => actualPageIndex > 0;

  bool get isNotLastPage => actualPageIndex < pages.length-1;
}