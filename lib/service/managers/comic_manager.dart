import 'package:komik/service/database/models/comic.dart';
import 'package:komik/service/repositories/comic_repository.dart';

class ComicManager {
  final ComicRepository _repository;

  ComicManager({
    required ComicRepository comic_repository
  }) : _repository = comic_repository;

  Stream<List<Comic>> find(
    String title
  ) {
    return _repository.findByTitle(title: title);
  }

  Stream<List<Comic>> fetch() {
    return _repository.get();
  }
}