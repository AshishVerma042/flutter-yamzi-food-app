import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

import '../customThaliManagement/Customization_Thali.dart';

class EditProfileScreen extends ParentWidget {
  final nameCtrl = TextEditingController(text: "Aashish Verma");
  final emailCtrl = TextEditingController(text: "aashish.verma@email.com");
  final phoneCtrl = TextEditingController(text: "+91 9876543210");

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.background,

      appBar:  appBar("Edit Profile"),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Column(
          children: [

            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: appColors.primary.withOpacity(0.25),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 58,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),

                ],
              ),
            ),
            30.kH,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              decoration: BoxDecoration(
                color: appColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: appColors.cardShadow,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  customField("Full Name", nameCtrl, Icons.person),
                  22.kH,

                  customField("Email", emailCtrl, Icons.email),
                  22.kH,

                  customField("Phone Number", phoneCtrl, Icons.phone),
                ],
              ),
            ),

            40.kH,

            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isEmpty || emailCtrl.text.isEmpty) {
                  Get.snackbar("Required", "Please fill all details");
                  return;
                }

                Get.back(result: {
                  "name": nameCtrl.text,
                  "email": emailCtrl.text,
                  "phone": phoneCtrl.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.primary,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Save Changes",
                style: TextStyle(fontSize: 17, color: appColors.iconOnPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(
      String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: 14,
              color: appColors.textPrimary,
              fontWeight: FontWeight.w600,
            )),

        8.kH,

        Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: appColors.greyLight),
            boxShadow: [
              BoxShadow(
                color: appColors.cardShadow,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: appColors.primary),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
