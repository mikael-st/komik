import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/reading_comic_card.dart';
import 'package:komik/service/managers/reading_manager.dart';

class ReadingPage extends StatelessWidget {
  final ReadingManager readingManager;

  const ReadingPage({
    super.key,
    required this.readingManager
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: StreamBuilder(
          stream: readingManager.fetch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _notFounded();
            }

            return Column(
              spacing: 12,
              children: List.generate(8, 
                (index) => ReadingComicCard(
                  width: double.infinity,
                  title: 'Titulo',
                  edition: '00',
                  actualPage: 0,
                  totalPages: 0,
                )
              ),
            );
          }
        )
      )
    );
  }

  Widget _notFounded() {
    return Center(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeroIcon(
            HeroIcons.bookmarkSquare,
            size: 52,
            color: Palette.comic_icon,
            style: HeroIconStyle.solid,
          ),
          Text('Nenhuma coleção', style: KomikTypography.base)
        ],
      ),
    );
  }
}