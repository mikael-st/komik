import 'dart:typed_data';

class ComicDTO {
  late String        title;
  late String?       subtitle = '';
  late String        edition;
  // late ComicTypeEnum type;
  late Uint8List     thumb;
  late String        path;

  ComicDTO({
    required this.title,
    required this.subtitle,
    required this.thumb,
    required this.edition,
    // required this.type,
    required this.path
  });

  @override
  String toString() {
    return 'Comic { title: $title;\nsubtitle: $subtitle;\nedition: $edition\n}';
  }
}