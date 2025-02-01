import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';

class CBZDecoder implements FileDecoder {
  final ZipDecoder _decoder;
  
  CBZDecoder({
    required ZipDecoder decoder
  }) : _decoder = decoder;

  @override
  decode(File file) {
    return _decoder.decodeStream(InputFileStream(file.path));
  }
}