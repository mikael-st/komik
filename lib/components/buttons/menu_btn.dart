import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        Navigator.pushNamed(context, '/settings');
        debugPrint('Open Bottom Menu');
      },
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(),
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft
      ),
      icon: HeroIcon(
        HeroIcons.adjustmentsHorizontal,
        style: HeroIconStyle.solid,
        color: Palette.white,
        size: 24,
      ),
    );
  }
}