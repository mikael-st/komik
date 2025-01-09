import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';

class Button extends StatelessWidget {
  final String content;
  final EdgeInsets padding;
  const Button({super.key, required this.content, required this.padding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){}, 
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: Palette.details,
        elevation: 0
      ),
      child: Padding(
        padding: padding,
          child: Text(
            content,
            style: TextStyle(
              color: Palette.white,
              fontWeight: FontWeight.bold
            ),
        ),
      ),
    );
  }
}