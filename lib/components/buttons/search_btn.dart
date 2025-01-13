import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        Navigator.pushNamed(context, '/search');
        print('Open SearchBar');
      },
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(),
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft
      ),
      icon: HeroIcon(
        HeroIcons.magnifyingGlass,
        color: Palette.white,
        size: 24,
      ),
    );
  }
}