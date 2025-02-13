import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/buttons/close_btn.dart';

class ComicEditToolbar extends StatelessWidget implements PreferredSizeWidget {
  const ComicEditToolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12)
        )
      ),
      backgroundColor: Palette.items,
      actions: [
        CloseBtn(
          action: () => debugPrint('Close and reset controllers'),
        ),
      ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(64);
}