import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/tool-bars/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchToolBar(),
        body: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Text('SearchPage', style: KomikTypography.card_title)
        )
      ),
    );
  }
}