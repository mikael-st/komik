import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/go_back_btn.dart';
import 'package:komik/components/buttons/menu_btn.dart';

class SearchToolBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchToolBar({super.key});

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
      title: TextField(
        decoration: InputDecoration(
          hoverColor: Palette.white,
          filled: true,
          fillColor: Palette.card,
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9999),
            borderSide: BorderSide.none,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
          ),
          suffixIcon: HeroIcon(
            HeroIcons.magnifyingGlass,
            color: Palette.white,
            size: 24,
          ),
        ),
      ),
      actions: [
        MenuBtn()
      ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(64);
}