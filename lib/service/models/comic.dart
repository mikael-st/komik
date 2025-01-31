import 'dart:typed_data';

import 'package:komik/service/utils/enums/comic_type_enum.dart';

class Comic {
  late String        name;
  late String        number;
  late ComicTypeEnum type;
  late Uint8List     thumb;

  Comic({
    required this.name,
    // required this.subtitle,
    required this.thumb,
    required this.number,
    required this.type
  });

  factory Comic.create(String fileName, Uint8List thumb) {
    final values = fileName.split('#');
    
    return Comic(
      name: values[0],
      number: values[1].split('-')[0],
      thumb: thumb,
      type: ComicTypeEnum.edition
    );
  }
}