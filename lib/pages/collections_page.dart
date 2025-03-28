import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/collection_card.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/managers/collection_manager.dart';

class CollectionsPage extends StatelessWidget {
  final CollectionManager collectionManager;

  const CollectionsPage({
    super.key,
    required this.collectionManager
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: StreamBuilder(
          stream: collectionManager.fetch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _notFounded();
            }

            return _content(context, snapshot.data!);
          }
        )
      ),
    );
  }

  Widget _content(BuildContext context, List<Collection> collections) {
    return Column(
      spacing: 12,
      children: collections.map(
        (collection) {
          collection.comics.sort((a,b) => a.edition.compareTo(b.edition));

          return CollectionCard(
            title: collection.title,
            editions: [collection.comics.first.edition, collection.comics.last.edition],
            thumb: collection.comics.first.thumb,
            callback: () => Navigator.pushNamed(context, '/collection', arguments: collection)
          );
        }
      ).toList(),
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
            HeroIcons.folder,
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