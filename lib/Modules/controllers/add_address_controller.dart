import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class AddAddressController extends GetxController {
  Rxn<LatLng> currentLocation = Rxn<LatLng>();
  Rxn<LatLng> selectedLocation = Rxn<LatLng>();
  RxString pinAddress = "".obs;

  RxString addressType = "Home".obs;


  RxBool showSuggestions = false.obs;
  RxList<Map<String, dynamic>> suggestions = <Map<String, dynamic>>[].obs;

  RxBool showAddressBox = false.obs;

  RxBool isLoading = true.obs;

  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();

  Timer? debounce;

  @override
  void onInit() {
    super.onInit();
    loadUserLocation();
  }

  Future<void> loadUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Permission Required", "Location permission is permanently denied.");
      return;
    }

    Position pos = await Geolocator.getCurrentPosition();
    LatLng loc = LatLng(pos.latitude, pos.longitude);

    currentLocation.value = loc;
    selectedLocation.value = loc;

    isLoading.value = false;

    mapController.move(loc, 16);
  }

  Future<void> goToMyLocation() async {
    Position pos = await Geolocator.getCurrentPosition();
    LatLng loc = LatLng(pos.latitude, pos.longitude);

    currentLocation.value = loc;
    selectedLocation.value = loc;

    mapController.move(loc, 16);
  }

  Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    if (query.isEmpty) return [];

    final safeQuery = Uri.encodeComponent(query);
    final url =
        "https://nominatim.openstreetmap.org/search?format=json&addressdetails=1&limit=10&q=$safeQuery";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "User-Agent": "yamzi-app",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    return [];
  }

  // Reverse geocoding (lat,lng → address)
  Future<String> getAddressFromLatLng(LatLng position) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json&addressdetails=1";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "User-Agent": "yamzi-app",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["display_name"] ?? "Unknown location";
    }

    return "Address not found";
  }
}
