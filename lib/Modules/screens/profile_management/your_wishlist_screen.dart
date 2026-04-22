import 'package:flutter/material.dart';
import 'package:yamzi/Modules/screens/profile_management/your_order_screen.dart';

import '../../../resources/colors.dart';
import '../customThaliManagement/Customization_Thali.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:  appBar("Your Wishlist"),

      body:detailCard(4,   CircleAvatar(
        radius: 32,
        backgroundColor: appColors.primary.withOpacity(0.1),
        child: Icon(Icons.favorite, color: appColors.primary, size: 26),
      ), "Item", "Tap to view details"),
    );
  }
}
