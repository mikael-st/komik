import 'package:flutter/material.dart';
import 'package:komik/components/devider/section_devider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 16),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.red,
      //     width: 1
      //   )
      // ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SectionDevider(
              text: 'Reading',
            )
          ],
        ),
      ),
    );
  }
}