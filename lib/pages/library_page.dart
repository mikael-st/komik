import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/comic_card.dart';
import 'package:komik/components/cards/reading_comic_card.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/utils/scroller/scroller.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: _content()
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Column(
        spacing: 28,
        children: [
          _reading(),
          _comics()
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

  Widget _comics() {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionDevider(
          text: 'Quadrinhos',
        ),
        Column(
          spacing: 12,
          children: List.generate(5, 
            (index) => ComicCard(
              title: 'Titulo',
              subtitle: 'Edição 00',
              callback: () => print('Open Comic Reader')/* Navigator.pushNamed(context, 'collection-info') */,
            )
          )
        )
      ],
    );
  }

  Widget _notFoundComics() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Nenhum quadrinho encontrado', style: KomikTypography.base),
        TextButton(
          onPressed: () => print('Go to Files Selector'),
          child: Text('Adicionar', style: KomikTypography.action_button)
        )
      ],
    );
  }
}