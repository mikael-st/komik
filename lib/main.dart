import 'package:archive/archive_io.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/icons/logo.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
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
// import 'package:komik/service/database/models/comic.dart';
// import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/cbz_decoder.dart';
import 'package:komik/service/utils/comic_loader.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/permissions_manager.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const KomikApp());
}

class KomikApp extends StatefulWidget {
  const KomikApp({super.key});

  @override
  State<KomikApp> createState() => _KomikAppState();
}

class _KomikAppState extends State<KomikApp> {
  final String appName = 'Komik';

  late PermissionsManager permissionManager;
  late FileManager fileManager;
  late ComicLoader comicLoader;

  int index = 0;

  bool hasBeenInitialize = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      permissionManager = PermissionsManager(
        validator: EasyPermissionValidator(
          context: context,
          appName: appName,
        )
      );
      fileManager = FileManager(permissionManager: permissionManager);
      comicLoader = ComicLoader(
        fileManager: fileManager,
        decoder: CBZDecoder(decoder: ZipDecoder())
      );
    });
    permissionManager.request().then(
      (_) {
        setState((){});
        fileManager.createComicsFolder();
        comicLoader.fetch();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
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
        '/reader': (context) => ReaderPage(fetchPages: comicLoader.fetchPages),
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
      body: permissionManager.haveStorageAccess
                  ? _content(index)
                  : _acceptStoragePermission(),
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

  Widget _acceptStoragePermission() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Aceite a permissão para acesso ao armazenamento',
            style: KomikTypography.base,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              debugPrint('Go to Phone Settings');
              openAppSettings();  
            },
            child: Text('Ir para configurações', style: KomikTypography.action_button)
          )
        ],
      )
    );
  }

  Widget _content(int index) {
    print('Storage Access: ${permissionManager.haveStorageAccess}');

    final pages = {
      0: LibraryPage(comics: comicLoader.comics),
      1: ComicsPage(),
      2: CollectionsPage(),
      3: ReadingPage()
    };

    return pages[index]!;
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