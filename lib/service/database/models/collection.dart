import 'package:komik/service/database/models/comic.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Collection {
  @Id(assignable: true)
  int id;
  
  late String        title;
  late String        description;

  @Backlink('collection')
  final comics = ToMany<Comic>();

  Collection({
    required this.id,
    required this.title,
    required this.description,
  });

}