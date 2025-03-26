import 'dart:typed_data';

import 'package:komik/objectbox.g.dart';
import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/dto/comic.dart';
import 'package:komik/service/dto/comic_infos.dart';

class ComicRepository {
  late Box<Comic> _box;

  ComicRepository({
    required Box<Comic> box
  }) : _box = box;

  void create({
    required ComicInfos infos,
    required Uint8List thumb,
    required String path,
  }) {
    final comic = Comic(
      title: infos.title,
      subtitle: infos.subtitle,
      edition: infos.edition,
      totalPages: infos.totalPages,
      thumb: thumb,
      path: path,
    );

    _box.put(comic);
  }

  Stream<List<Comic>> get() {
    return _box
            .query()
            .watch(triggerImmediately: true)
            .map((value) => value.find());
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
}