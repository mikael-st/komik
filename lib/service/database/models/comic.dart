/* import 'dart:typed_data';

import 'package:komik/service/utils/enums/comic_type_enum.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Comic {
  @Id()
  int id;
  
  late String        title;
  late String        subtitle;
  late String        edition;
  late Uint8List     thumb;
  late String        path;
  late ComicTypeEnum type;

  Comic({
    this.id = 0,
    required this.title,
    required this.subtitle,
    required this.thumb,
    required this.edition,
    required this.path,
    this.type = ComicTypeEnum.edition
  });
} */