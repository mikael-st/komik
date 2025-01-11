import 'package:flutter/material.dart';
import 'package:komik/components/cards/comic_card.dart';

class ComicsPage extends StatelessWidget {
  const ComicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: double.infinity,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          spacing: 12,
          children: List.generate(8, 
            (index) => ComicCard(
              title: 'Title',
              subtitle: 'Edição 00',
            )
          ),
        )
        )
      );
  }
}