import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../controllers/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appColors.surface,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: appColors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            itemCount: 6,
            padding: EdgeInsets.all(16),
            itemBuilder: (_, __) => shimmerNotificationCard(),
          );
        }

        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              "No notifications yet",
              style: TextStyle(fontSize: 16, color: appColors.textMuted),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (_, index) {
            final item = controller.notifications[index];
            return Container(
              margin: EdgeInsets.only(bottom: 14),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: item["isRead"] ? appColors.surface : appColors.primaryVariant.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: appColors.cardShadow,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: appColors.fab,
                    child: Icon(Icons.notifications, color: appColors.iconOnPrimary),
                  ),
                  12.kW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: appColors.textPrimary,
                          ),
                        ),
                        4.kH,
                        Text(
                          item["message"],
                          style: TextStyle(
                            fontSize: 14,
                            color: appColors.textMuted,
                          ),
                        ),
                        6.kH,
                        Text(
                          item["time"],
                          style: TextStyle(
                            fontSize: 12,
                            color: appColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!item["isRead"]) ...[
                    SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: appColors.badge,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget shimmerNotificationCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: appColors.greyLight,
              shape: BoxShape.circle,
            ),
          ),
          12.kW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: 150,
                  color: appColors.greyLight,
                ),
                6.kH,
                Container(
                  height: 12,
                  width: 220,
                  color: appColors.greyLight,
                ),
                6.kH,
                Container(
                  height: 10,
                  width: 80,
                  color: appColors.greyLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}