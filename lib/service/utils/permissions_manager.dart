import 'package:get/get.dart';
import 'package:komik/assets/palette.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  Future<bool> storage() async {
    try {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else {
        Get.snackbar('Permissão negada',
          'Por favor, aceite a permissão para acessar asmúsicas',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.items,
          colorText: Palette.white
        );
        storage();
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}