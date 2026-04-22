import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class AddressController extends GetxController {
  final addressList = <Map<String, dynamic>>[].obs;

  void saveAddress(String type, Map<String, dynamic> data) {
    data["type"] = type;
    addressList.add(data);
  }

  void deleteAddress(Map<String, dynamic> data) {
    addressList.remove(data);
  }

  Future<bool> checkLocationPermission() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
