import 'package:flutter/material.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/Customization_Thali.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar("Help & Support"),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            helpCard(
              Icons.chat_bubble_outline,
              "Chat with Support",
              "Get real-time assistance",
            ),

            16.kH,

            helpCard(
              Icons.call_outlined,
              "Call Us",
              "Speak with our support team",
            ),

            16.kH,

            helpCard(
              Icons.email_outlined,
              "Email Support",
              "support@yamzi.com",
            ),
          ],
        ),
      ),
    );
  }

  Widget helpCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: appColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: appColors.primary.withOpacity(0.1),
            child: Icon(icon, color: appColors.primary, size: 26),
          ),

          14.kW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: appColors.textPrimary)),
                SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: appColors.textMuted)),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios, size: 18, color: appColors.textMuted),
        ],
      ),
    );
  }
}
