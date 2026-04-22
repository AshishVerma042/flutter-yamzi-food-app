import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/Customization_Thali.dart';
import 'package:yamzi/Modules/screens/profile_management/privacy_policy.dart';
import 'package:yamzi/Modules/screens/profile_management/term_and_condition.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: appBar("Legal & Support"),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            legalTile(
              title: "Terms & Conditions",
              icon: Icons.description_outlined,
              onTap: () => Get.to(() => TermsConditionsScreen()),
            ),

            14.kH,

            legalTile(
              title: "Privacy Policy",
              icon: Icons.lock_outline,
              onTap: () => Get.to(() => PrivacyPolicyScreen()),
            ),

          ],
        ),
      ),
    );
  }

  Widget legalTile({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.orange,
                size: 22,
              ),
            ),

            16.kW,

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
