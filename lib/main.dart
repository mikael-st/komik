import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/icons/logo.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/components/tool-bars/tool_bar.dart';
import 'package:komik/pages/collection_info.dart';
import 'package:komik/pages/collections_page.dart';
import 'package:komik/pages/comics_page.dart';
import 'package:komik/pages/edit_comic_infos.dart';
import 'package:komik/pages/library_page.dart';
import 'package:komik/pages/reader_page.dart';
import 'package:komik/pages/reading_page.dart';
import 'package:komik/pages/search_page.dart';
import 'package:komik/pages/settings/local_files_page.dart';
import 'package:komik/pages/settings/settings.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/cbz_decoder.dart';
import 'package:komik/service/utils/fetch_comics.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/permissions_manager.dart';

void main() {
  runApp(const KomikApp());
}

class KomikApp extends StatefulWidget {
  const KomikApp({super.key});

  @override
  State<KomikApp> createState() => _KomikAppState();
}

class _KomikAppState extends State<KomikApp> {
  final PermissionsManager permissionManager = PermissionsManager();
  late FetchComics fetchComics = FetchComics(
    fileManager: FileManager(permissionManager: permissionManager),
    decoder: CBZDecoder(decoder: ZipDecoder())
  );

  late List<Comic> comics = [];

  bool hasBeenInitialize = false;

  int index = 0;
  late Map<int, Widget> content = {
    0: LibraryPage(comics: comics),
    1: ComicsPage(),
    2: CollectionsPage(),
    3: ReadingPage()
  };

  @override
  void initState() {
    super.initState();
    permissionManager.storage();
    fetchComics.fetch().then(
      (files) => setState(() {
        comics = files;
        hasBeenInitialize = true;
      })
    );
  }

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
      initialRoute: '/',
      routes: {
        '/': (context) => _app(),
        '/search': (context) => SearchPage(),
        '/collection': (context) => CollectionInfoPage(),
        '/reader': (context) => ReaderPage(fetchPages: fetchComics.fetchPages),
        '/settings': (context) => Settings(),
        '/local-files': (context) => LocalFilesPage(),
        '/edit-comic': (context) => EditComicInfos()
      },
    );
  }

  Widget _app() {
    return Scaffold(
      appBar: ToolBar(
        leading: Logo(),
      ),
      body: hasBeenInitialize ? content[index] : _loading(),//_content(),
      bottomNavigationBar: _navBar(),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: Palette.details,
      ),
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
            setState(() {
                index = value;
              }
            );
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