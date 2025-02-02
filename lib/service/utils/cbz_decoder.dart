import 'package:archive/archive_io.dart';
import 'package:komik/service/utils/interfaces/file_decorder.dart';

class CBZDecoder implements FileDecoder {
  final ZipDecoder _decoder;
  
  CBZDecoder({
    required ZipDecoder decoder
  }) : _decoder = decoder;

  @override
  decode(String filePath) {
    return _decoder.decodeStream(InputFileStream(filePath));
  }
}