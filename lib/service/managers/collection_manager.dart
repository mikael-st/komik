import 'package:komik/objectbox.g.dart';
import 'package:komik/service/database/models/collection.dart';

class CollectionManager {
  final Box<Collection> _box;

  CollectionManager({
    required Box<Collection> box
  }) : _box = box;

  int create({
    required String title,
    required String description
  }) {
    final collection = Collection(
      title: title,
      description: description
    );

    return _box.put(collection);
  }

  Stream<List<Collection>> fetch() {
    return _box
            .query()
            .watch(triggerImmediately: true)
            .map((value) => value.find());
  }

  Collection? get({ required int id }) {
    return _box.get(id);
  }

  Collection? findByTitle({
    required String title
  }) {
    return _box
            .query(
              Collection_.title.equals(title)
            ).build().findFirst();
            // .watch(triggerImmediately: true).map((value) => value.find());
  }

  /* void edit({
    required int id,
    required ComicDTO update
  }) {
    final comic = _box.get(id);

    if (comic != null) {
      
    }
  } */
}