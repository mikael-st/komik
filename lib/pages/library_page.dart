import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/cards/reading_comic_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/utils/scroller/scroller.dart';
import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/models/comic.dart';

class LibraryPage extends StatelessWidget {
  final Stream<List<Comic>> comics;

  const LibraryPage({
    super.key,
    required this.comics
  });

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
            stream: comics,
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

  Widget _comicsFounded(BuildContext context, List<Comic> comics) {
    return Column(
      spacing: 12,
      children: comics.map( 
        (comic) => ComicCard(
          title: comic.title,
          subtitle: 'Edição ${comic.edition}',
          thumb: comic.thumb,
          callback: () => Navigator.pushNamed(
                            context,
                            '/reader',
                            arguments: comic as ComicReaderInfos
                          ),
        )
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