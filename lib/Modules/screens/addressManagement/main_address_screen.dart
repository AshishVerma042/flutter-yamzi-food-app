import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/Customization_Thali.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../controllers/address_controller.dart';
import 'add_address_screen.dart';

class AddressListScreen extends StatelessWidget {
  final controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.surface,
      appBar: appBar(appStrings.myAddresses),

      body: Obx(() {
        return controller.addressList.isEmpty
            ? emptyAddressView()
            : ListView(
          padding: EdgeInsets.all(16),
          children: [
            for (var item in controller.addressList)
              addressCard(item),
            20.kH,
          ],

        );
      }),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () async {
            bool allowed = await controller.checkLocationPermission();

            if (allowed) {
              var result = await Get.to(() => AddAddressScreen());

              if (result case final value?) {
                controller.saveAddress(
                    value["type"],
                    {"address": value["address"]}
                );
              }

            } else {
              Get.snackbar(appStrings.permissionRequired, appStrings.locationPermissionRequired);
            }
          },
          icon: Icon(Icons.add,color: appColors.iconOnPrimary,),
          label: Text(appStrings.addNewAddress,style: TextStyle(color: appColors.iconOnPrimary),),
          style: ElevatedButton.styleFrom(
            backgroundColor: appColors.primary,
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }

  Widget emptyAddressView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 80, color: appColors.grey),
          16.kH,
          Text(
            appStrings.noAddressAdded,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget addressCard(Map<String, dynamic> address) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: appColors.cardShadow),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: appColors.primary, size: 32),
          12.kW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address["type"] ?? "Address",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appColors.textPrimary),
                ),

                4.kH,

                Text(
                  address["address"] ?? "",
                  style: TextStyle(fontSize: 13, color: appColors.textPrimary),
                ),
              ],
            ),
          ),

          IconButton(
            icon: Icon(Icons.delete, color: appColors.danger),
            onPressed: () => controller.deleteAddress(address),
          ),
        ],
      ),
    );
  }
}


