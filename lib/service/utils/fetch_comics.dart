import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';
import 'package:path/path.dart' as path;

class FetchComics {
  final FileManager _fileManager;
  final FileDecoder _decoder;
  
  FetchComics({
    required FileDecoder decoder,
    required FileManager fileManager
  }) : _fileManager = fileManager, _decoder = decoder;
  
  Future<List<Comic>> fetch() async {
    try {
      await _fileManager.renameCBR();
      final files = await _fileManager.getCBZ();

      return files.map(
        (file) {
          final fileName = path.basename(file.path).replaceAll('.cbz', '');

          return Comic.create(
            fileName: fileName,
            path: file.path,
            thumb: fetchThumb(file)
          );
          // final comicInfos = fetchInfos(fileName);
          /* return Comic(
            title: comicInfos['title']!,
            subtitle: comicInfos['subtitle']!,
            edition: comicInfos['edition']!,
            path: file.path,
            thumb: fetchThumb(file)
          ); */
        }
      ).toList();
    } catch (err) {
      throw Exception(err);
    }
  }

  Map<String, String> fetchInfos(String fileName) {
    final values = fileName.split('#');

    return {
      'title': values[0],
      'edition': values[1].split('-')[0],
      'subtitle': values[1].split('-')[1],
    };
  }

  Uint8List fetchThumb(File file) {
    var archives = _decoder.decode(file);

    final image = archives.where((archive) => archive.name.contains('01')).first;

    return image.content;
  }

  bool isImage(String name) {
    if (
      name.endsWith('.png') ||
      name.endsWith('.jpg') ||
      name.endsWith('.jpeg')
    ) {
      return true;
    } else {
      return false;
    }
  }

  List<Uint8List> fetchPages(String path) {
    final archives = _decoder
                      .decode(File(path))
                      .files;
    
    return archives.where((archive) => isImage(archive.name))
                   .map((archive) => archive.content)
                   .toList();
  }
}