import 'package:flutter/material.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

import '../customThaliManagement/Customization_Thali.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar("Your Orders"),

      body: detailCard(5,   Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: appColors.primary.withOpacity(0.1),
        ),
        child: Icon(Icons.fastfood, color: appColors.primary, size: 32),
      ), "Order", "Delivery on 25 Jan 2025  ")
    );
  }
}

Widget detailCard (int count,Widget leading,String title,String subtitle,{int trailing = 0} ){
  return ListView.builder(
    padding: EdgeInsets.all(16),
    itemCount: count,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
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
            leading,
            14.kW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${title} ${index + 1}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: appColors.textPrimary),
                  ),
                  4.kW,
                  Text(subtitle,
                    style: TextStyle(color: appColors.textMuted),
                  ),
                ],
              ),
            ),
            trailing > 0
                ? Text(
              "₹${trailing * (index+1)}",
              style: TextStyle(color: appColors.green),
            )
                : Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: appColors.textMuted,
            ),
          ],
        ),
      );
    },
  );
}
