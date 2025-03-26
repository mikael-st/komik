import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:komik/service/dto/comic_infos.dart';
import 'package:komik/service/repositories/comic_repository.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ComicLoader {
  late FileManager _fileManager;

  late FileDecoder _decoder;
  
  late ComicRepository _comicRepository;

  ComicLoader({
    required FileDecoder decoder,
    required FileManager fileManager,
    required ComicRepository comic_repository,
  }) {
    _fileManager = fileManager;
    _decoder = decoder;
    _comicRepository = comic_repository;
  }
  
  void load() async {
    try {
      _fileManager.fetch().listen(
        (File file) {
          _comicRepository.create(
            infos: fetchInfos(file.path),
            thumb: fetchThumb(file.path),
            path: file.path
          );
        },
        onError: (err) {
          debugPrint(err);
        }
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  ComicInfos fetchInfos(String fileName) {
    final values = path.basename(fileName).split('-');

    final infos = ComicInfos();
      infos.title = values[0];
      infos.subtitle = values[values.length - 1]!=values[0] ? values[values.length - 1] : '';
      infos.edition = '00';
      infos.totalPages = fetchPages(fileName).length;

    return infos;
  }

  Uint8List fetchThumb(String filePath) {
    try {
      final archives = _decoder.decode(filePath);
      
      return archives.where((archive) =>  isImage(archive.name) && isThumb(archive.name)).first.content;
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

  bool isThumb(String name) {
    if (
      name.contains('01') ||
      name.contains('00')
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
      debugPrint('$fileName >>> ARQUIVO NÃO SUPORTADO');
      return [];
    }
  }
}