import 'dart:typed_data';

import 'package:komik/service/dto/comic_reader_infos.dart';
import 'package:komik/service/utils/enums/comic_type_enum.dart';

class Comic implements ComicReaderInfos{
  @override
  late String        title;
  late String?        subtitle = '';
  late String        edition;
  late ComicTypeEnum type;
  late Uint8List     thumb;
  @override
  late String        path;

  Comic({
    required this.title,
    required this.subtitle,
    required this.thumb,
    required this.edition,
    required this.type,
    required this.path
  });

  factory Comic.create({
    required Map<String, String> infos,
    required Uint8List thumb,
    required String path
  }) {
    return Comic(
      title: infos['title']!,
      edition: infos['edition']!,
      subtitle: infos['subtitle'],
      thumb: thumb,
      type: ComicTypeEnum.edition,
      path: path
    );
  }

  @override
  String toString() {
    return 'Comic { title: $title;\nsubtitle: $subtitle;\nedition: $edition\n}';
  }
}