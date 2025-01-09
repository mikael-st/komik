import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';

void main() {
  runApp(const KomikApp());
}

class KomikApp extends StatelessWidget {
  const KomikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Palette.background,
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        textTheme: GoogleFonts.poppinsTextTheme(),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: ToolBar(),
        body: Center(
          child: Text('OK!!', style: TextStyle(color: Palette.white),),
        ),
      )
    );
  }
}