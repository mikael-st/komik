import 'package:flutter/material.dart';
import 'package:komik/components/cards/comic.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: List.generate(8, 
            (index) => Comic(
              title: 'Titulo',
              subtitle: '00 - 00 edições',
            )
          ),
        )
      ),
    );
  }
}