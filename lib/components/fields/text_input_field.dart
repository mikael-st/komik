import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextInputField({
    super.key,
    required this.label,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style:KomikTypography.base),
          TextField(
            controller: controller,
            style: KomikTypography.base,
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.items,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)
              )
            ),
          )
        ],
      ),
    );
  }
}