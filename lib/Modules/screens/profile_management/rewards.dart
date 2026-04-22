import 'package:flutter/material.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

import '../../../resources/colors.dart';
import '../customThaliManagement/Customization_Thali.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:  appBar("Reward"),

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          rewardCard("Daily Check-in", "Earn 10 points", Icons.calendar_month),
          16.kH,
          rewardCard("Order Rewards", "Earn 2 points per ₹100", Icons.stars),
          16.kH,
          rewardCard("Referral Bonus", "Earn 500 points per friend", Icons.group_add),
          16.kH,
          rewardCard("Gift Vouchers", "Redeem points for vouchers", Icons.card_giftcard),
        ],
      ),
    );
  }

  Widget rewardCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: appColors.primary.withOpacity(0.1),
            child: Icon(icon, color: appColors.primary, size: 28),
          ),
          14.kW,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                4.kH,
                Text(subtitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
