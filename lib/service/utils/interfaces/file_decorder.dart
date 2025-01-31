import 'dart:io';

import 'package:archive/archive_io.dart';

interface class FileDecoder {
  external Archive decode(File file);
}