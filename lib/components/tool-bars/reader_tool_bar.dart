import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/go_back_btn.dart';
class ReaderToolBar extends StatelessWidget implements PreferredSizeWidget {
  const ReaderToolBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.items,
      leading: GoBackBtn(),
      title: Text('Titulo', style: KomikTypography.title),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(64);
}