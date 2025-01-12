import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/go_back_btn.dart';
import 'package:komik/components/buttons/see_more.dart';
import 'package:komik/components/cards/comic_thumb.dart';
import 'package:komik/components/devider/section_devider.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';

class CollectionInfoPage extends StatelessWidget {

  const CollectionInfoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ToolBar(
          leading: GoBackBtn(),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 1)
          ),
          margin: EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              spacing: 20,
              children: [
                _infos(),
                _comics()
              ],
            )
          )
        ),
    );
  }

  Widget _infos(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1)
        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          ComicThumb(),
          _details()
        ],
      ),
    );
  }

  Widget _details(){
    final title = Text('Titulo', style: KomikTypography.title,);
    final description = Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      overflow: TextOverflow.ellipsis,
      maxLines: 7,
      textAlign: TextAlign.justify,
      style: KomikTypography.base,
    );

    final descriptionCard =Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1)
        ),
        child: Column(
          children: [
            description,
            SeeMoreBtn()
          ],
        )
      );

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

  Widget _comics(/* Widget card */) {
    return Column(
      children: [
        SectionDevider(text: 'Edições')
      ],
    );
  }
}