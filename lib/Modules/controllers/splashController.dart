import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/RoutesClass.dart';
import '../screens/authenticationMangement/login_screen.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> leftTextAnimation;
  late Animation<Offset> rightTextAnimation;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration:  Duration(seconds: 2),
    );

    leftTextAnimation = Tween(
      begin:  Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    ));

    rightTextAnimation = Tween(
      begin:  Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    ));

    animationController.forward();

    Future.delayed( Duration(seconds: 3), () {
       Get.toNamed(RoutesClass.gotohomeScreen());
    });

    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

