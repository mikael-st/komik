import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';

class SeeMoreBtn extends StatelessWidget {
  const SeeMoreBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: (){
        print("See More");
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(double.infinity, 14)
      ),
      iconAlignment: IconAlignment.end,
      icon: HeroIcon(
        HeroIcons.chevronDown,
        color: Palette.details,
        style: HeroIconStyle.micro,
      ),
      label: Text('Ver mais ', style: KomikTypography.see_more),
    );
  }
}