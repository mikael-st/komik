import 'package:get/get.dart';
import 'package:komik/assets/palette.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  bool access = false;

  Future<void> request() async {
    try {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> accessStorageGranted() {
    return Permission.storage.isGranted;
  }

  /* SnackbarController request() {
    return Get.snackbar('Permissão negada',
          'Por favor, aceite a permissão para acessar os arquivos',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.items,
          colorText: Palette.white
        );
  } */
}