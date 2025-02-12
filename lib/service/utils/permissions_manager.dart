import 'package:get/get.dart';
import 'package:komik/assets/palette.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  final bool _access = false;
  set _access(bool value) => _access = value;


  Future<void> request() async {
    try {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> accessStorageGranted() async {
    _access = await Permission.storage.isGranted;
    return _access;
  }

  bool get haveAccessStorage => _access;
  
  /* SnackbarController request() {
    return Get.snackbar('Permissão negada',
          'Por favor, aceite a permissão para acessar os arquivos',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.items,
          colorText: Palette.white
        );
  } */
}