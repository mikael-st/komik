// import 'package:objectbox/objectbox.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:komik/objectbox.g.dart';

// class DB {
//   late Store _store;

//   Future<void> init() async {
//     final dir = await getApplicationDocumentsDirectory();
  
//     _store = Store(
//       getObjectBoxModel(),
//       directory: join(dir.path, 'localdata')
//     );
//   }

//   void dispose() {
//     _store.close();
//   }

//   Store get store => _store;
// }