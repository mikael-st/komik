import 'package:archive/archive_io.dart';

interface class FileDecoder {
  external Archive decode(String filePath);
}