import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/Modules/screens/profile_management/policies_screen.dart';
import 'package:yamzi/Modules/screens/profile_management/refunds_screen.dart';
import 'package:yamzi/Modules/screens/profile_management/rewards.dart';
import 'package:yamzi/Modules/screens/profile_management/update_screen.dart';
import 'package:yamzi/Modules/screens/profile_management/your_order_screen.dart';
import 'package:yamzi/Modules/screens/profile_management/your_wishlist_screen.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../addressManagement/main_address_screen.dart';
import 'gift_card_screen.dart';
import 'help_support_screen.dart';

class StylishProfileScreen extends StatelessWidget {
  const StylishProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.kH,
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: appColors.textPrimary),
            ),
            profileSection(),

            20.kH,

            Center(
              child: Column(
                children: [
                  Text(
                    "Aashish Verma",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: appColors.textPrimary,
                    ),
                  ),
                  Text("+91 9810389546",style: TextStyle(color: appColors.textMuted,fontSize: 16),)
                ],
              ),
            ),

            25.kH,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  statCard(
                    Icons.shopping_bag_outlined,
                    "  Your\nOrders",
                    appColors.fab, () {
                    Get.to(() => YourOrdersScreen());
                  },
                  ),
                  12.kW,
                  statCard(
                    Icons.favorite_border,
                    "   Your\nWishlist",
                    appColors.pinkAccent,
                     () {
                    Get.to(() => WishlistScreen());
                  },
                  ),
                  12.kW,
                  statCard(Icons.headphones, " Help &\nSupport", appColors.primary, () {
                    Get.to(() => HelpSupportScreen());
                  },),
                ],
              ),
            ),
            24.kH,

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                  profileTile(
                    Icons.currency_rupee_outlined,
                    "Your Refunds",
                    "Refunds & cashback points",
                    onTap: () {
                      Get.to(() => RefundScreen());
                    },
                  ),
                  Divider(color: appColors.greyLight),
                  profileTile(
                    Icons.location_on_outlined,
                    "Address",
                    "Manage your addresses",
                    onTap: () {
                      Get.to(() => AddressListScreen());
                    },
                  ),

                  Divider(color: appColors.greyLight), profileTile(
                    Icons.credit_card_outlined,
                    "E-Gift Cards",
                    "Manage online credits",
                    onTap: () {
                      Get.to(() => EGiftCardScreen());
                    },
                  ),
                  Divider(color: appColors.greyLight),
                  profileTile(
                    Icons.redeem,
                    "Rewards",
                    "Vouchers & Gift",
                    onTap: () {
                      Get.to(() => RewardsScreen());
                    },
                  ),
                  Divider(color: appColors.greyLight),
                  profileTile(
                    Icons.account_circle_outlined,
                    "Profile",
                    "Update your profile",
                    onTap: () {
                      Get.to(() => EditProfileScreen());
                    },
                  ),

                ],
              ),
            ),

            20.kH,

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                  otherTile(
                    Icons.info,
                    "General info",
                      onTap: () {
                        Get.to(() => LegalScreen());
                      }
                  ),

                ],
              ),
            ),
            20.kH,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                    icon: Icon(Icons.logout, color: appColors.iconOnPrimary),
                    label: Text(
                      "Logout",
                      style: TextStyle(color: appColors.iconOnPrimary, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.primary,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  30.kH,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileTile(
  IconData icon,
  String title,
  String value, {
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Icon(icon, color: appColors.primary, size: 22),
        12.kW,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: appColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              2.kH,
              Text(
                value,
                style: TextStyle(
                  color: appColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget profileSection() {
  return Center(
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: appColors.fab.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
        ),
      ],
    ),
  );
}

Widget statCard(IconData icon, String label, Color color, Function()?onTap) {
  return Expanded(
    child: GestureDetector(onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: appColors.cardShadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            6.kH,
            Text(label, style: TextStyle(fontSize: 12, color: appColors.textMuted)),
          ],
        ),
      ),
    ),
  );
}


Widget otherTile(
    IconData icon,
    String value, {
      VoidCallback? onTap,
    }) {
  return InkWell(
    onTap: onTap,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: appColors.primary, size: 22),
            12.kW,
            Center(
              child: Text(
                value,
                style: TextStyle(
                  color: appColors.textPrimary,
                  fontWeight: FontWeight.bold,fontSize: 16
                ),
              ),
            ),
          ],
        ),

        Icon(Icons.arrow_forward_ios_outlined,size: 20, color: appColors.textPrimary)
      ],
    ),
  );
}
