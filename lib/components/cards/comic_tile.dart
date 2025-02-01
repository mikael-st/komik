import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/cards/comic_thumb.dart';

class ComicTile extends StatelessWidget {
  const ComicTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        spacing: 12,
        children: [
          ComicThumb(
            thumb: MemoryImage(Uint8List(0)),
          ),
          Text('#00', style: KomikTypography.action_button)
        ],
      ),
    );
  }
}