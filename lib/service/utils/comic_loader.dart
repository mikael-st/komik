import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';
import 'package:path/path.dart' as path;

class ComicLoader {
  final FileManager _fileManager;
  final FileDecoder _decoder;
  final StreamController<List<String>> controller = StreamController<List<String>>();
  
  ComicLoader({
    required FileDecoder decoder,
    required FileManager fileManager
  }) : _fileManager = fileManager, _decoder = decoder;
  
  Future<void> fetch() async {
    try {
      debugPrint('CALLED ComicLoader.fetch()');
      
      final List<String> comics = [];

      _fileManager.fetch();
      
      _fileManager.files.listen(
        (File file) {
          final comic = _convertFileToComic(file);
          debugPrint(comic.title);
          comics.add(comic.title);
          controller.add(List.from(comics));
        },
        onDone: () {
          debugPrint('ALL COMICS LOADED');
          controller.close();
        }
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  Comic _convertFileToComic(File file) {
      final extension = path.extension(file.path);
      final fileName = path.basename(file.path).replaceAll(extension, '').trim();

      return Comic.create(
        infos: fetchInfos(fileName),
        thumb: fetchThumb(file.path),
        path: file.path
      );
  }

  Map<String, String> fetchInfos(String fileName) {
    final values = fileName.split('-');

    return {
      'title': values[0],
      'edition': '00',
      'subtitle': values[values.length - 1]!=values[0] ? values[values.length - 1] : '',
    };
  }

  Uint8List fetchThumb(String filePath) {
    try {
      final archives = _decoder.decode(filePath);
      
      return archives.where((archive) => archive.name.contains('01.jpg') || archive.name.contains('000.jpg')).first.content;
    } on PathNotFoundException {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');

      debugPrint('$fileName >>> ARQUIVO NÃO SUPORTADO');

      return Uint8List(0);
    } on StateError {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');

      debugPrint('$fileName >>> ARQUIVO CORROMPIDO');

      return Uint8List(0);
    }
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

  List<MemoryImage> fetchPages(String filePath) {
    try {
      final archives = _decoder
                      .decode(filePath)
                      .files;
      return archives.where((archive) => isImage(archive.name))
                   .map((archive) => MemoryImage(archive.content))
                   .toList();
    } on StateError {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');

      debugPrint('$fileName >>> ARQUIVO CORROMPIDO');

      return [];
    } catch (err) {
      throw Exception(err);
    }
  }

  Stream<List<String>> get comics => controller.stream;
}