import 'dart:async';

import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/cards/reading_comic_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/utils/scroller/scroller.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/comic_loader.dart';

class LibraryPage extends StatefulWidget {
  // final Stream<List<String>> comics;
  final ComicLoader comicLoader;

  const LibraryPage({
    super.key,
    required this.comicLoader
  });

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final controller = StreamController<List<String>>();
  final List<String> numbers = [];

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.topCenter,
      child: _content(context)
    );
  }

  Widget _content(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      value++;
      numbers.add('$value');
      controller.add(List.from(numbers));
    });

    return SingleChildScrollView(
      child: Column(
        spacing: 28,
        children: [
          _reading(),
          _comics(context)
        ],
      )
    );
  }

  Widget _reading() {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionDevider(
          text: 'Lendo',
        ),
        Scroller(
          direction: Axis.horizontal,
          amount: 5,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ReadingComicCard(),
        )
      ],
    );
  }

  Widget _comics(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionDevider(
          text: 'Quadrinhos',
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
            stream: widget.comicLoader.controller.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _notFoundComics();
              }
  
              return _comicsFounded(context, snapshot.data!);
            }
          )
        )
      ],
    );
  }

  Widget _comicsFounded(BuildContext context, List<String> comics) {
    return Column(
      spacing: 12,
      children: comics.map( 
        (comic) => Text(comic, style: KomikTypography.base)
        
        /* ComicCard(
          title: comic.title,
          subtitle: 'Edição ${comic.edition}',
          thumb: comic.thumb,
          callback: () => Navigator.pushNamed(
                            context,
                            '/reader',
                            arguments: comic as ComicReaderInfos
                          ),
        )*/
      ).toList()
    );
  }

  Widget _notFoundComics() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Nenhum quadrinho encontrado', style: KomikTypography.base),
        TextButton(
          onPressed: () => debugPrint('Go to Files Selector'),
          child: Text('Adicionar', style: KomikTypography.action_button)
        )
      ],
    );
  }
}

// 