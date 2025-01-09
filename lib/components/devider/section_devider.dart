import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';

class SectionDevider extends StatelessWidget {
  final String text;
  const SectionDevider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: KomikTypography.label,),
        Expanded (
          child: Container(
            margin: EdgeInsets.only(left: 10),
            height: 2,
            color: Palette.details,
          ),
        )
      ],
    );
  }
}