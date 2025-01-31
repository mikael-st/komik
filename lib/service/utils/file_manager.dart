import 'dart:io';

import 'package:komik/service/utils/permissions_manager.dart';

class FileManager {
  final String _path = '/storage/emulated/0/Comics';
  final PermissionsManager _permissionManager;

  const FileManager({
    required PermissionsManager permissionManager
  }) : _permissionManager = permissionManager;

  Future<List<FileSystemEntity>> _getFiles() async {
    if (await _permissionManager.storage()) {
      try {
        final directory = Directory(_path);
        print('pegando arquivos');
        return await directory.list().toList();
      } catch (err) {
        throw Exception(err);
      }
    } else {
      print('Permissão negada');
      return [];
    }
  }

  Future<List<File>> getCBZ() async {
    final comics = await _getFiles();
    
    return comics
    .where((file) => file is File && file.path.endsWith('.cbz'))
    .map((f) => File(f.path))
    .toList();
  }

  renameCBR() async {
    final comics = await _getFiles();
    
    comics.where((file) => file is File && file.path.endsWith('.cbr')).toList();
  
    for (final comic in comics) {
      await comic.rename(comic.path.replaceRange(comic.path.length-1, comic.path.length, 'z'));
    }
  }

}