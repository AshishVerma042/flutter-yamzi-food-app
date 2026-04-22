import 'package:flutter/material.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/Customization_Thali.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar("Privacy Policy"),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.cardShadow,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: appColors.textPrimary,
                      ),
                    ),

                    14.kH,

                    Text(
                      "Your privacy is important to us. Below is how we protect and use your data:",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: appColors.textPrimary,
                      ),
                    ),

                    16.kH,

                    bullet("We do not sell your personal information."),
                    bullet("Your data is stored securely with encryption."),
                    bullet("Location is used only to improve services."),
                    bullet("We do not share your personal data with third parties."),
                    bullet("You may request account or data deletion anytime."),

                    20.kH,

                    Row(
                      children: [
                        Icon(Icons.email_outlined, size: 20, color: appColors.primary),
                        10.kW,
                        Expanded(
                          child: Text(
                            "For more information, email: privacy@example.com",
                            style: TextStyle(
                              fontSize: 15,
                              color: appColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: appColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          10.kW,
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
