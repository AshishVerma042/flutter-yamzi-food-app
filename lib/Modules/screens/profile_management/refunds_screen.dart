import 'package:flutter/material.dart';
import 'package:yamzi/Modules/screens/profile_management/your_order_screen.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';

import '../customThaliManagement/Customization_Thali.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar("Your Refunds"),

      body: detailCard(4, Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: appColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.currency_rupee, color: appColors.primary, size: 28),
      ) ,  'Refund #', "Processed on 22 Jan 2025", trailing: 150)
    );
  }
}
