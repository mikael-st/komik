import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/go_back_btn.dart';
import 'package:komik/components/buttons/menu_btn.dart';
import 'package:komik/components/buttons/search_btn.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12)
        )
      ),
      backgroundColor: Palette.items,
      leading: GoBackBtn(),
      actions: [
        SearchBtn(),
        MenuBtn()
      ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(64);
}