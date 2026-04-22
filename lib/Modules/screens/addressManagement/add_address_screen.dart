import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../controllers/add_address_controller.dart';
import '../customThaliManagement/Customization_Thali.dart';

class AddAddressScreen extends ParentWidget {
  final AddAddressController controller = Get.put(AddAddressController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    if (!controller.isLoading.value) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(color: appColors.primary)),
      );
    }

    return Scaffold(
      appBar: appBar(appStrings.searchLocation),
      backgroundColor: appColors.surface,

      body: Stack(
        children: [

          /// ---------- FIX: FlutterMap should NEVER be inside Obx ----------
          FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: controller.currentLocation.value ?? LatLng(0, 0),
              initialZoom: 16,
              onTap: (tapPos, latlng) async {
                controller.selectedLocation.value = latlng;
                controller.showAddressBox.value = false;

                final address = await controller.getAddressFromLatLng(latlng);
                controller.pinAddress.value = address;

                Future.delayed(Duration(milliseconds: 200), () {
                  controller.showAddressBox.value = true;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),

              /// ---------- FIX: Only Marker is reactive ----------
              Obx(() {
                return MarkerLayer(
                  markers: [
                    Marker(
                      point: controller.selectedLocation.value ?? LatLng(0, 0),
                      width: 180,
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          controller.showAddressBox.value
                              ? Container(
                            width: 160,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: appColors.surface,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: appColors.cardShadow, blurRadius: 4)
                              ],
                            ),
                            child: Text(
                              controller.pinAddress.value,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, color: appColors.textPrimary),
                            ),
                          )
                              : SizedBox(height: 20),

                          Icon(Icons.location_pin,
                              color: appColors.danger, size: 35),
                          SizedBox(height: 85),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),

          // ----------------------- SEARCH BOX -----------------------
          Positioned(
            top: 20,
            left: 12,
            right: 12,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (text) {
                      controller.debounce?.cancel();
                      controller.debounce = Timer(
                        Duration(milliseconds: 900),
                            () async {
                          final result =
                          await controller.getSuggestions(text);

                          controller.suggestions.value = result;
                          controller.showSuggestions.value =
                              result.isNotEmpty && text.isNotEmpty;
                        },
                      );
                    },
                    decoration: InputDecoration(
                      hintText: appStrings.searchLocation,
                      hintStyle: TextStyle(color: appColors.textMuted),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: appColors.textMuted),
                    ),
                  ),
                ),

                /// ---------- Suggestions list ----------
                Obx(() {
                  if (!controller.showSuggestions.value)
                    return SizedBox();

                  return Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: appColors.cardShadow, blurRadius: 8),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.suggestions.length,
                      itemBuilder: (_, index) {
                        final item = controller.suggestions[index];

                        return ListTile(
                          title: Text(item["display_name"] ?? "", style: TextStyle(color: appColors.textPrimary)),
                          onTap: () async {
                            final lat = double.parse(item["lat"]);
                            final lon = double.parse(item["lon"]);
                            final loc = LatLng(lat, lon);

                            controller.selectedLocation.value = loc;
                            controller.showSuggestions.value = false;
                            controller.searchController.text =
                                item["display_name"] ?? "";

                            controller.mapController.move(loc, 16);

                            final addr =
                            await controller.getAddressFromLatLng(loc);
                            controller.pinAddress.value = addr;
                          },
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          Positioned(
            bottom: 40,
            right: 15,
            child: FloatingActionButton(
              backgroundColor: appColors.primary,
              child: Icon(Icons.my_location, color: appColors.iconOnPrimary),
              onPressed: controller.goToMyLocation,
            ),
          ),
        ],
      ),

      bottomNavigationBar: _saveButton(context),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => _openBottomSheet(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.primary,
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          appStrings.saveAddress,
          style: TextStyle(color: appColors.iconOnPrimary),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) async {
    LatLng loc = controller.currentLocation.value ?? LatLng(0, 0);
    String autoAddress = await controller.getAddressFromLatLng(loc);

    String finalAddress = controller.pinAddress.value.isEmpty
        ? autoAddress
        : controller.pinAddress.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      backgroundColor: appColors.background,
      builder: (context) {
        TextEditingController houseCtrl = TextEditingController();
        TextEditingController landmarkCtrl = TextEditingController();
        TextEditingController streetCtrl = TextEditingController();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: _buildBottomSheet(
              houseCtrl, streetCtrl, landmarkCtrl, finalAddress),
        );
      },
    );
  }

  Widget _buildBottomSheet(houseCtrl, streetCtrl, landmarkCtrl,
      finalAddress) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: appColors.greyMedium,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          20.kH,
          Text(
            appStrings.addAddressDetails,
            style: TextStyle(
              color: appColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          16.kH,

          /// Inputs...
          _inputBox(appStrings.houseNo, appStrings.enterHouseNo, houseCtrl),
          14.kH,
          _inputBox(appStrings.street, appStrings.enterStreet, streetCtrl),
          14.kH,
          _inputBox(appStrings.landmark, appStrings.enterLandmark, landmarkCtrl),

          20.kH,
          Text(appStrings.detectedAddress,
              style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: appColors.textPrimary)),
          8.kH,
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: appColors.greyLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: appColors.greyMedium.withOpacity(0.5)),
            ),
            child: Text(finalAddress, style: TextStyle(color: appColors.textPrimary)),
          ),

          20.kH,
          Text(appStrings.addressType,
              style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: appColors.textPrimary)),
          10.kH,
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _typeButton(appStrings.home,
                    controller.addressType.value == "Home"),
                _typeButton(appStrings.work,
                    controller.addressType.value == "Work"),
                _typeButton(appStrings.other,
                    controller.addressType.value == "Other"),
              ],
            );
          }),
          20.kH,

          ElevatedButton(
            onPressed: () {
              if (houseCtrl.text.isEmpty ||
                  landmarkCtrl.text.isEmpty) {
                Get.snackbar(
                    appStrings.required, appStrings.pleaseFillHouseLandmark);
                return;
              }

              String combined =
                  "${houseCtrl.text}, ${streetCtrl.text}, ${landmarkCtrl.text}, $finalAddress";

              Get.back();
              Get.back(result: {
                "address": combined,
                "type": controller.addressType.value,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appColors.primary,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: Size(double.infinity, 52),
            ),
            child: Text(
              appStrings.saveCompleteAddress,
              style: TextStyle(
                  fontSize: 16,
                  color: appColors.iconOnPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          20.kH,
        ],
      ),
    );
  }

  Widget _inputBox(
      String label, String hint, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.w600, color: appColors.textPrimary)),
        6.kH,
        Container(
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: appColors.cardShadow, blurRadius: 4),
            ],
          ),
          child: TextField(
            controller: ctrl,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: appColors.textMuted),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _typeButton(String title, bool isSelected) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Get.find<AddAddressController>().addressType.value = title;
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? appColors.primary : appColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? appColors.primary
                : appColors.greyMedium,
          ),
          boxShadow: [
            BoxShadow(
              color: appColors.cardShadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? appColors.iconOnPrimary : appColors.textPrimary,
            ),
          ),
        ),
      ),
    ),
  );
}
