import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';

class PermissionsManager {
  final EasyPermissionValidator _validator;

  late bool haveStorageAccess = false;
  // set _access(bool value) => _access = value;

  PermissionsManager({
    required EasyPermissionValidator validator
  }) : _validator = validator;

  Future<void> request() async {
    try {
      if (await androidVersion() < 11) {
        haveStorageAccess = await _validator.storage();
      } else {
        haveStorageAccess = await _validator.manageExternalStorage();
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<int> androidVersion() async {
    final device = DeviceInfoPlugin();
    final android = await device.androidInfo;

    return int.parse(android.version.release.split('.')[0]);
  }

}