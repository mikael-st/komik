import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';
import 'package:komik/pages/collections_page.dart';
import 'package:komik/pages/comics_page.dart';
import 'package:komik/pages/library_page.dart';
import 'package:komik/pages/reading_page.dart';

void main() {
  runApp(const KomikApp());
}

class KomikApp extends StatefulWidget {
  const KomikApp({super.key});

  @override
  State<KomikApp> createState() => _KomikAppState();
}

class _KomikAppState extends State<KomikApp> {
  int index = 0;

  Map<int, Widget> content = {
    0: LibraryPage(),
    1: ComicsPage(),
    2: CollectionsPage(),
    3: ReadingPage()
  };

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
        body: content[index],
        bottomNavigationBar: _navBar(),
      )
    );
  }

  Widget _navBar() {
    return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Palette.details, width: 2))),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(
              TextStyle(
                color: Palette.white,
                fontSize: 12,
              )
            )
          ),
          child: NavigationBar(
          onDestinationSelected: (value) {
            setState(() => index = value);
            print(index);
          },
          destinations: [
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.home,
                style: HeroIconStyle.solid,
                size: 24,
                color: Palette.white,
              ),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.bookmarkSquare,
                style: HeroIconStyle.solid,
                size: 24,
                color: Palette.white,
              ),
              label: 'Quadrinhos',
            ),
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.folder,
                style: HeroIconStyle.solid,
                size: 24,
                color: Palette.white,
              ),
              label: 'Coleções',
            ),
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.clock,
                size: 24,
                color: Palette.white,
              ),
              label: 'Lendo',
            ),
          ],
          selectedIndex: index,
          backgroundColor: Palette.items,
          indicatorColor: const Color.fromARGB(83, 228, 25, 59),
        )),
      );
  }
}