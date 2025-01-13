import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/go_back_btn.dart';
import 'package:komik/components/cards/comic_thumb.dart';
import 'package:komik/components/cards/comic_tile.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';

class CollectionInfoPage extends StatefulWidget {
  
  const CollectionInfoPage({super.key});

  @override
  State<CollectionInfoPage> createState() => _CollectionInfoPageState();
}

class _CollectionInfoPageState extends State<CollectionInfoPage> {
  late Widget actualDescription;

  @override
  void initState() {
    actualDescription = _shortDescription();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ToolBar(
          leading: GoBackBtn(),
        ),
        body: Container(
          height: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              spacing: 20,
              children: [
                _infos(),
                SectionDevider(text: 'Edições'),
                _comics(
                  ComicTile()
                )
              ],
            )
          )
        ),
    );
  }

  Widget _infos(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          ComicThumb(),
          _details(
            actualDescription
          )
        ],
      ),
    );
  }

  Widget _details(Widget descriptionCard){
    final title = Text('Titulo', style: KomikTypography.title,);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          title,
          descriptionCard
        ],
      ),
    );
  }

  Widget _shortDescription() {
    final description = Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      overflow: TextOverflow.ellipsis,
      maxLines: 7,
      textAlign: TextAlign.justify,
      style: KomikTypography.base,
    );

    return Column(
      children: [
        description,
        _seeMoreBtn(
          icon: HeroIcons.chevronDown,
          action: () => {
            setState(() => actualDescription = _fullDescription())
          }
        )
      ],
    );
  }

  Widget _fullDescription() {
    final description = Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      textAlign: TextAlign.justify,
      style: KomikTypography.base,
    );

    return Column(
      children: [
        description,
        _seeMoreBtn(
          icon: HeroIcons.chevronUp,
          action: () => {
            setState(() => actualDescription = _shortDescription())
          }
        )
      ],
    );
  }

  Widget _comics(Widget card) {
    return Column(
      spacing: 12,
      children: List.generate(5, (index) => card)
    );
  }

  Widget _seeMoreBtn({
    required HeroIcons icon,
    required Function() action
  }) {
    return TextButton.icon(
      onPressed: (){
        action();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(double.infinity, 14)
      ),
      iconAlignment: IconAlignment.end,
      icon: HeroIcon(
        icon,
        color: Palette.details,
        style: HeroIconStyle.micro,
      ),
      label: Text('Ver mais ', style: KomikTypography.see_more),
    );
  }
}