import 'package:komik/service/database/models/comic.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Reading {
  @Id()
  int id = 0;

  final int actualPage;
  final int totalPages;
  
  final comic = ToOne<Comic>();

  Reading({
    required this.actualPage,
    required this.totalPages
  });

}