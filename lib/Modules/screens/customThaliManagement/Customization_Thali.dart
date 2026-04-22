import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/thali_preview.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../../common/gradient.dart';
import '../../../routes/RoutesClass.dart';
import '../../controllers/customizationController.dart';

class CustomizationScreen extends ParentWidget {
  final controller = Get.put(CustomizationController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar(appStrings.customizedThali,trailingIcon: true,controller: controller),
      body: SingleChildScrollView(
        child: Column(
          children: [
            12.kH,
            ThaliPreview(controller: controller),
            12.kH,
            thaliSelectionSection(controller, h, w, context),

            orderSummary(context,controller)
          ],
        ),
      ),
    );
  }
}


Widget orderSummary(BuildContext context, CustomizationController controller) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appStrings.selectedItems,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        12.kH,

        Obx(() {
          if (controller.selectedItems.isEmpty) {
            return Center(
              child: Text(
                appStrings.noItemsSelected,
                style: TextStyle(color: appColors.textMuted),
              ),
            );
          }

          return Column(
            children: controller.getSelectedItemsDetails().map((detail) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(detail['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(
                            '₹${detail['price']} x ${detail['quantity']}',
                            style: TextStyle(fontSize: 12, color: appColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${detail['total']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: appColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appStrings.totalPrice,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Text(
              '₹${controller.totalPrice.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: appColors.primary,
              ),
            )),
          ],
        ),

        20.kH,

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (controller.selectedItems.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(appStrings.pleaseSelectAtLeastOneItem)),
                );
                return;
              }

              controller.orderController.addCustomizedOrder(
                thaliType: controller.selectedThaliType.value,
                items: controller.getSelectedItemsDetails(),
                totalPrice: controller.totalPrice.value,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(appStrings.thaliAddedToYourOrders)),
              );

              controller.resetCustomization();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              appStrings.addToCart,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: appColors.iconOnPrimary,
              ),
            ),
          ),
        ),

        10.kH,
      ],
    ),
  );
}

  Map<String, List<dynamic>> groupItemsByType(List<dynamic> items) {
    final grouped = <String, List<dynamic>>{};

    for (var item in items) {
      final type = item['type']?.toString() ?? 'Unknown';
      var list = grouped[type] ?? <dynamic>[];
      list.add(item);
      grouped[type] = list;
    }

    return grouped;
  }

  PreferredSizeWidget appBar(String title,{bool trailingIcon = false ,dynamic controller}) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    flexibleSpace: Container(decoration: BoxDecoration(gradient: AppGradients.appBarGradient),),
    leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back,color: appColors.iconOnPrimary,)),
    title: Text(
      title,
      style: TextStyle(
        color: appColors.iconOnPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
    ),
    titleSpacing: 0,
    actions: [
      trailingIcon==true ?
      Stack(
        children: [
          IconButton(onPressed: (){Get.toNamed(RoutesClass.gotoOrderScreen());
          }, icon: Icon(Icons.shopping_cart_outlined,color: appColors.iconOnPrimary,)),
          Obx(()=>(controller.orderController.orders.isNotEmpty)?
          Positioned(top: 4,right: 4,
              child: Container(width: 18,height: 18,decoration: BoxDecoration(color: appColors.badge,borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text("${controller.orderController.orders.length}",
                        style: TextStyle(color: appColors.iconOnPrimary,fontWeight: FontWeight.bold,)),
                  ))):SizedBox.shrink()
          )
        ],
      ):SizedBox.shrink()
    ],
    automaticallyImplyLeading: false,

  );
}


Widget thaliSelectionSection  (dynamic controller, double h, double w,BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          toggleWidget(controller,w),
          12.kH,
          itemListWidget(context,controller,w,h),
        ],
      ),
    );
  }

  Widget toggleWidget(dynamic controller,double w) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Obx(
                () => Container(
              height: 45,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: appColors.greyLight,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: Duration(milliseconds: 250),
                    alignment: controller.selectedThaliType.value == 'Vegetarian'
                        ? Alignment.centerLeft
                        : controller.selectedThaliType.value == 'Non-Vegetarian'
                        ? Alignment.centerRight
                        : Alignment.center,
                    child: Container(
                      width: w * 0.33,
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: controller.selectedThaliType.value == 'Vegetarian'
                            ? appColors.success
                            : controller.selectedThaliType.value ==
                            'Non-Vegetarian'
                            ? appColors.danger
                            : appColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      toggleItem("Veg", "Vegetarian",controller),
                      toggleItem("All", "Mix",controller),
                      toggleItem("Non-Veg", "Non-Vegetarian",controller),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget toggleItem(String label, String value,dynamic controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedThaliType.value = value;
          controller.selectedItems.clear();
          controller.calculateTotal();
          controller.triggerShimmer();
        },
        child: Center(
          child: Obx(
                () => Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: controller.selectedThaliType.value == value
                    ? appColors.iconOnPrimary
                    : appColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemListWidget(BuildContext context, dynamic controller, double w, double h) {
    return Obx(() {
      final items = controller.getAvailableItems();
      final groupedItems = groupItemsByType(items);

      if (controller.showShimmer.value) {
        return Column(
          children: List.generate(6, (i) => _shimmerItemCard()),
        );
      }
      return Column(
        children: groupedItems.entries.map((entry) {
          final type = entry.key;
          final typeItems = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appColors.textPrimary,
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: typeItems.length,
                itemBuilder: (context, index) {
                  final item = typeItems[index];
                  return menuItemCard(item, context, w, h, controller);
                },
              ),
              10.kH
            ],
          );
        }).toList(),
      );
    });
  }


Widget menuItemCard(
    dynamic item,
    BuildContext context,
    double w,
    double h,
    CustomizationController controller,
    ) {
  return Obx(() {
    final quantity = controller.selectedItems[item['id']] ?? 0;
    return Card(
      color: appColors.surface,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['imageUrl'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            12.kW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 4),
                  Text(
                    '₹${item['price']}',
                    style: TextStyle(
                      color: appColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            (quantity == 0)
                ? GestureDetector(
              onTap: () => controller.addItem(item['id']),
              child: _addButton(),
            )
                : quantityChanger(quantity, controller, item),
          ],
        ),
      ),
    );
  });
}

Widget _addButton() {
  return Container(
    width: 60,
    height: 32,
    decoration: BoxDecoration(
      color: appColors.primary,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: Text(
        'Add',
        style: TextStyle(
          color: appColors.iconOnPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ),
  );
}

Widget quantityChanger(int quantity, controller, item) {
  return Row(
    children: [
      GestureDetector(
        onTap: () => controller.removeItem(item['id']),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: appColors.danger,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.remove, color: appColors.iconOnPrimary, size: 16),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text('$quantity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
      GestureDetector(
        onTap: () => controller.addItem(item['id']),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: appColors.success,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.add, color: appColors.iconOnPrimary, size: 16),
        ),
      ),
    ],
  );
}


Widget _shimmerItemCard() {
  return Shimmer.fromColors(
    baseColor: appColors.greyLight,
    highlightColor: appColors.surface,
    period: Duration(seconds: 2),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      height: 72,
      decoration: BoxDecoration(
        color: appColors.greyLight,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
