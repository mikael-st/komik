import 'package:flutter/material.dart';
import 'package:komik/components/cards/reading_comic.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: List.generate(8, 
            (index) => ReadingComic()
          ),
        )
        )
      );
  }
}