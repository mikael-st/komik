import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/go_back_btn.dart';

class SettingsToolBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  const SettingsToolBar({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.transparent,
      leading: GoBackBtn(),
      title: title,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2),
        child: Divider(
          color: Palette.comic_icon,
          thickness: 2,
          height: 2,
        )
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(72);
}