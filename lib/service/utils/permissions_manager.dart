import 'package:get/get.dart';
import 'package:komik/assets/palette.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  Future<bool> checkPermission() async {
    try {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else {
        Get.snackbar('Permissão negada',
          'Por favor, aceite a permissão para acessar asmúsicas',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.details,
          colorText: Palette.white
        );
        checkPermission();
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}