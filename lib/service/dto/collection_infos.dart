import 'package:komik/service/database/models/comic.dart';

interface class CollectionInfos {
  late String title;
  late String description;
  late List<Comic> comics;
}