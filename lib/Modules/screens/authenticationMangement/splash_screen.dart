import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/resources/strings.dart';
import '../../controllers/splashController.dart';
import '../../../main.dart';

class SplashScreen extends ParentWidget {
  const SplashScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor:  Color.fromARGB(195, 247, 243, 233),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SlideTransition(
              position: controller.leftTextAnimation,
              child:  Text(
                appStrings.yam,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SlideTransition(
              position: controller.rightTextAnimation,
              child:  Text(
                appStrings.zi,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
