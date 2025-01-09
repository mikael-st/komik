import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class GoBackBtn extends StatelessWidget {
  const GoBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        print('Go Back');
      },
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(),
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft
      ),
      icon: HeroIcon(
        HeroIcons.chevronLeft,
        color: Palette.white,
        size: 24,
      ),
    );
  }
}