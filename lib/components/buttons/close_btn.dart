import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/modals/options_modal.dart';

class CloseBtn extends StatelessWidget {
  final Function() action;
  const CloseBtn({
    super.key,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(),
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
      ),
      icon: HeroIcon(
        HeroIcons.xMark,
        color: Palette.white,
        size: 24,
      ),
    );
  }
}