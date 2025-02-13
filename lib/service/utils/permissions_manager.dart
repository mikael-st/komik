import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  final EasyPermissionValidator _validator;

  late bool haveStorageAccess = false;
  // set _access(bool value) => _access = value;

  PermissionsManager({
    required EasyPermissionValidator validator
  }) : _validator = validator;

  Future<void> request() async {
    try {
      final result = await _validator.requestPermission(
        Permission.manageExternalStorage
      );

      haveStorageAccess = result;
    } catch (err) {
      throw Exception(err);
    }
  }

}