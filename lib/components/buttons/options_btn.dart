import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class OptionsBtn extends StatelessWidget {
  const OptionsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        print('Open Options Menu');
      },
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(),
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft
      ),
      icon: HeroIcon(
        HeroIcons.ellipsisVertical,
        color: Palette.white,
        size: 24,
      ),
    );
  }
}