import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/components/buttons/add_btn.dart';
import 'package:komik/components/cards/folder_tile.dart';
import 'package:komik/components/tool-bars/settings_toolbar.dart';

class LocalFilesPage extends StatelessWidget {
  const LocalFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsToolBar(
        title: Text('Local dos arquivos', style: KomikTypography.option)
      ),
      body: _content(),
      floatingActionButton: AddBtn(
        action: () {
          debugPrint('Open file picker');
        },
      ),
    );
  }

  Widget _content() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(2, (index) => FolderTile()),
        ),
      ),
    );
  }
}