import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komik/objectbox.g.dart';
import 'package:komik/service/database/models/collection.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/comic.dart';
import 'package:komik/service/dto/comic_infos.dart';

class ComicManager {
  late Box<Comic> _box;

  ComicManager({
    required Box<Comic> box
  }) : _box = box;

  int create({
    required ComicInfos infos,
    required Uint8List thumb,
    required String path,
    Collection? collection
  }) {
    final comic = Comic(
      title: infos.title,
      subtitle: infos.subtitle,
      edition: infos.edition,
      actualPage: infos.actualPage,
      totalPages: infos.totalPages,
      thumb: thumb,
      path: path,
    )..collection.target=collection;

    return _box.put(comic);
  }

  Stream<List<Comic>> fetch() {
    debugPrint('INIT TO FETCH COMICS IN DATABASE');
    
    return _box
            .query()
            .watch(triggerImmediately: true)
            .map((value) => value.find());
  }

  Comic? get({ required int id }) {
    return _box.get(id);
  }

  Stream<List<Comic>> findByTitle({
    required String title
  }) {
    return _box
            .query(
              Comic_.title.equals(title)
            )
            .watch(triggerImmediately: true).map((value) => value.find());
  }

  void edit({
    required int id,
    required ComicDTO update
  }) {
    final comic = _box.get(id);

    if (comic != null) {
      
    }
  }

  Future<bool> haveNoData() async {
    final data = await fetch().first;

    return data.isEmpty;
  }
}