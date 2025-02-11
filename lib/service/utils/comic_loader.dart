import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';
import 'package:path/path.dart' as path;

class ComicLoader {
  final FileManager _fileManager;
  final FileDecoder _decoder;
  final StreamController<List<Comic>> _controller = StreamController<List<Comic>>();
  
  ComicLoader({
    required FileDecoder decoder,
    required FileManager fileManager
  }) : _fileManager = fileManager, _decoder = decoder;
  
  Future<void> fetch() async {
    try {
      final List<Comic> comics = [];

      _fileManager.getFiles();
      _fileManager.files.listen(
        (List<File> files) {
          files.isNotEmpty ? comics.add(_convertFileToComic(files.last)) : null;
        },
        onDone: () { _controller.add(comics); },
        onError: (err) {print('DEU ERRO CARALHOOOOOO $err');}
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
    final archives = _decoder.decode(filePath);
    
    if (archives.isEmpty) {
      return Uint8List(0);
    }

    var image = Uint8List(0);

    try {
      image = archives.where((archive) => archive.name.contains('01') || archive.name.contains('000')).first.content;
    } catch (e) {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');

      print('$fileName >>> ARQUIVO NÃO SUPORTADO');

      return Uint8List(0);
    }

    return image;
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
    final archives = _decoder
                      .decode(filePath)
                      .files;
    try {
      return archives.where((archive) => isImage(archive.name))
                   .map((archive) => MemoryImage(archive.content))
                   .toList();
    } catch (e) {
      final extension = path.extension(filePath);
      final fileName = path.basename(filePath).replaceAll(extension, '');
      print('$fileName >>> ARQUIVO NÃO SUPORTADO');
      return [];
    }
  }

  Stream<List<Comic>> get comics => _controller.stream;
}