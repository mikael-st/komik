import 'package:komik/service/models/comic.dart';
import 'package:komik/service/utils/file_manager.dart';
import 'package:path/path.dart' as path;

class FetchComics {
  final FileManager _fileManager;
  
  FetchComics({
    required FileManager fileManager
  }) : _fileManager = fileManager;
  
  Future<List<Comic>> fetch() async {
    try {
      await _fileManager.renameCBR();
      final files = await _fileManager.getCBZ();

      files.map(
        (file) {
          final fileName = path.basename(file.path);
          print(fileName);
        }
      ).toList();
    } catch (err) {
      throw Exception(err);
    }
    
    return [];
  }
}