import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:komik/service/utils/permissions_manager.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final String _path = '/storage/emulated/0/Comics';
  final PermissionsManager _permissionsManager;

  const FileManager({
    required PermissionsManager permissionsManager
  }) : _permissionsManager = permissionsManager;

  Future<List<FileSystemEntity>> _getFiles() async {
    if (await _permissionsManager.checkPermission()) {
      try {
        final directory = Directory(_path);

        return await directory.list().toList();
      } catch (err) {
        throw Exception(err);
      }
    } else {
      await _permissionsManager.checkPermission();
      return [];
    }
  }

  Future<List<FileSystemEntity>> getCBZ() async {
    final comics = await _getFiles();
    
    return comics.where(
      (file) => file is File && file.path.endsWith('.cbr')).toList();
  }

  Future<List<FileSystemEntity>> getCBR() async {
    final comics = await _getFiles();
    
    return comics.where(
      (file) => file is File && file.path.endsWith('.cbr')).toList();
  }

  Future<List<String>> _extractImages(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    extractFileToDisk(file.path, path);

    final images = await tempDir.list();
    
    return images.map((file) => file.path).toList();
  }
}