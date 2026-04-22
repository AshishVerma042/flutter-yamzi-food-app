import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/customizationController.dart';

class ThaliPreview extends StatelessWidget {
  final CustomizationController controller;

  const ThaliPreview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedItems.keys.toList();

      final itemCount = selected.isEmpty ? 16 : selected.length;


      const double thaliWidth = 285;
      const double thaliHeight = 293;
      const double circleRadius = 80;
      const double bowlSize = 48;
      const double innerImageSize = 34;

      return SizedBox(
        width: thaliWidth,
        height: thaliHeight,
        child: Stack(
          alignment: Alignment.center,
          children: () {
            List<Widget> widgets = [
              Image.asset(
                'assets/images/thali_base.png',
                width: thaliWidth,
                height: thaliHeight,
                fit: BoxFit.cover,
              ),
            ];

            for (int i = 0; i < itemCount; i++) {
              double dx = 0;
              double dy = 0;

              if (i > 0) {
                double angle = (2 * pi / (itemCount - 1)) * (i - 1);
                dx = circleRadius * cos(angle);
                dy = circleRadius * sin(angle);
              }

              final bool isCenter = i == 0;
              final double bowlSizeNow = isCenter ? 120 : bowlSize;
              final double innerImageSizeNow = isCenter ? 92 : innerImageSize;

              final itemId = (i < selected.length) ? selected[i] : null;
              final item = (itemId != null)
                  ? controller.allMenuItems.firstWhere(
                    (e) => e['id'] == itemId,
                orElse: () => {},
              )
                  : null;

              widgets.add(
                Positioned(
                  left: (thaliWidth / 2) + dx - (bowlSizeNow / 2),
                  top: (thaliHeight / 2) + dy - (bowlSizeNow / 2),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (item?.isEmpty== false )
                      Image.asset(
                        "assets/images/bowl.png",
                        width: bowlSizeNow,
                        height: bowlSizeNow,
                        fit: BoxFit.cover,
                      ),
                      if (item != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(innerImageSizeNow),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            item['imageUrl'],
                            width: innerImageSizeNow,
                            height: innerImageSizeNow,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }


            return widgets;
          }(),
        ),
      );
    });
  }
}
