import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestLocationPermission() async {
  var status = await Permission.location.request();

  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    Get.snackbar("Permission Needed", "Please allow location permission to use map");
    return false;
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }

  return false;
}
