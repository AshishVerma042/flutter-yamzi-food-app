import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() async {
    await Future.delayed(Duration(seconds: 2));
    notifications.value = [
      {
        "title": "Order Delivered!",
        "message": "Your Special Thali has arrived. Enjoy your meal! 🍽️",
        "time": "5 mins ago",
        "isRead": false,
      },
      {
        "title": "Flat 20% OFF",
        "message": "Grab discount on your next thali order. Limited Time!",
        "time": "1 hour ago",
        "isRead": true,
      },
      {
        "title": "New Menu Added",
        "message": "Try our new customizable premium thalis!",
        "time": "Yesterday",
        "isRead": true,
      },
    ];
    isLoading.value = false;
  }
}
