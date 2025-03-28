import 'package:komik/objectbox.g.dart';
import 'package:komik/service/database/models/reading.dart';
import 'package:komik/service/managers/comic_manager.dart';

class ReadingManager {
  final Box<Reading> _box;

  final ComicManager _comicManager;

  ReadingManager({
    required Box<Reading> box,
    required ComicManager comic_manager
  }) : _box = box, _comicManager = comic_manager;

  void create({
    required int comicID,
    required int actualPage,
    required int totalPages
  }) {
    final comic = _comicManager.get(id: comicID);

    final reading = Reading(
      actualPage: actualPage,
      totalPages: totalPages
    )..comic.target = comic;

    _box.put(reading);
  }

  Stream<List<Reading>> fetch() {
    return _box
            .query()
            .watch(triggerImmediately: true)
            .map((value) => value.find());
  }

  bool hasContent() {
    return _box.isEmpty();
  }
}