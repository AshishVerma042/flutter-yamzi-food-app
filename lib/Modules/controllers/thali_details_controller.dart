import 'package:get/get.dart';
import 'home_controller.dart';
import 'orderController.dart';

class ThaliDetailController extends GetxController {

  final HomeController homeController = Get.put(HomeController());
  final OrderController orderController = Get.put(OrderController());


  // late Map item;
  late Map<String, dynamic> item;


  @override
  void onInit() {
    item = Get.arguments;
    super.onInit();
  }
}