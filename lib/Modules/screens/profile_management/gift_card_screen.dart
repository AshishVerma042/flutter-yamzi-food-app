import 'package:flutter/material.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/Customization_Thali.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

class EGiftCardScreen extends StatelessWidget {
  const EGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar("E-Gift Cards"),

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          giftCard("₹500 Gift Card", "Valid for 12 months", ),
          16.kH,
          giftCard("₹1000 Gift Card", "Valid for 12 months", ),
          16.kH,
          giftCard("₹2000 Gift Card", "Valid for 1 year", ),
        ],
      ),
    );
  }

  Widget giftCard(String title, String subtitle){
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: appColors.surface,
        boxShadow: [
          BoxShadow(
            color: appColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color:  appColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.card_giftcard, color:  appColors.primary, size: 30),
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
