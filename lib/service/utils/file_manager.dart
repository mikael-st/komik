import 'dart:async';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:komik/service/utils/permissions_manager.dart';

class FileManager {
  final PermissionsManager _permissionManager;
  final StreamController<List<File>> _controller = StreamController<List<File>>();
  
  FileManager({
    required PermissionsManager permissionManager
  }) : _permissionManager = permissionManager;

  Future<void> createComicsFolder() async {
    if (await _permissionManager.accessStorageGranted()) {
      final path = await ExternalPath.getExternalStorageDirectories();
      
      final directory = await Directory('${path[0]}/Comics').create(recursive: true);
    }
  }

  Future<void> getFiles() async {
    if (await _permissionManager.accessStorageGranted()) {
      try {
        final path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_COMICS);
        
        final directory = Directory(path);

        final files = await directory.list().toList();
        final List<File> comics = [];

        for (var file in files) {
          if (isComicFile(file as File)) {
            await _renameCBR(file);
            comics.add(file);
            _controller.add(List.from(comics));
          }
        }
        _controller.close();
      } catch (err) {
        throw Exception(err);
      }
    } else {
      _permissionManager.request();
    }
  }

  bool isComicFile(File file) {
    if (file.path.endsWith('.cbz') || file.path.endsWith('.cbr')) {
      return true;
    } else {
      return false;
    }
  }

  _renameCBR(File file) async {
    if (file.path.endsWith('.cbr')) {
      await file.rename(file.path.replaceAll('.cbr', '.cbz'));
    }
  }

  Stream<List<File>> get files => _controller.stream;

}