import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamzi/common/common_widgets.dart';
import 'package:yamzi/common/gradient.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../../routes/RoutesClass.dart';
import '../../controllers/home_controller.dart';
import 'notification_screen.dart';

class HomeScreen extends ParentWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());


  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.background,
      body: CustomScrollView(
        slivers: [
          homeSliverAppBar(controller, w, context),

          SliverToBoxAdapter(
            child: Container(
              width: w,
              padding: EdgeInsets.only(top: 20),
              color: appColors.background,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 18.0),
                    child: commonSearchBar(
                      w,
                      48,
                      appStrings.searchYourFavoriteThali,hintStyle: TextStyle(color: appColors.primary),
                      borderRadius: 10,fillColor: appColors.primary.withOpacity(0.1),
                      prefixIcon: Icon(Icons.search, color: appColors.primary),
                    ),
                  ),
                  20.kH,
                  discountScrollSection(controller),
                ],
              ),
            ),
          ),

          SliverAppBar(
            pinned: true,
            expandedHeight: 0,
            backgroundColor: appColors.background,
            elevation: 0,
            surfaceTintColor: appColors.background,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            primary: false,
            toolbarHeight: 90,
            title: Padding(
              padding: EdgeInsets.only(left: 18, right: 18, top: 30),
              child: thaliCategorySection(controller),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [foodGrid(controller, w)],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          55.kW,
          Obx(
            () => (controller.orderController.orders.isNotEmpty)
                ? viewCart(controller)
                : SizedBox.shrink(),
          ),
          customThaliButton(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget customThaliButton() {
  return Padding(
    padding: EdgeInsets.only(right: 30.0, bottom: 70),
    child: FloatingActionButton(
      onPressed: () {
        Get.toNamed(RoutesClass.gotocustomScreen());
      },
      backgroundColor: appColors.fab,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: appColors.cardShadow, blurRadius: 5),
            ],
          ),
          child: Image.asset("assets/images/dish.png"),
        ),
      ),
    ),
  );
}

Widget viewCart(dynamic homeController) {
  return Stack(
    children: [
      FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(RoutesClass.gotoOrderScreen());
        },
        backgroundColor: appColors.success,
        label: Text(
          appStrings.viewCart,
          style: TextStyle(fontWeight: FontWeight.bold, color: appColors.surface),
        ),
        icon: Icon(Icons.shopping_cart_outlined, color: appColors.surface),
      ),
      Positioned(
        top: 4,
        right: 4,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: appColors.badge,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              "${homeController.orderController.orders.length}",
              style: TextStyle(
                color: appColors.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget customToggle({
  required bool value,
  required String text,
  required Color activeColor,
  required Function(bool) onChanged,
}) {
  final bool isVeg = text.toUpperCase() == "VEG";
  return Container(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    decoration: BoxDecoration(
      color: appColors.surface,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: appColors.cardShadow, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ),
    child: GestureDetector(
      onTap: () => onChanged(!value),
      child: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 260),
              width: 42,
              height: 12,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: value
                    ? activeColor.withOpacity(0.85)
                    : appColors.greyLight,
              ),
            ),
          ),

          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 280),
              width: 42,
              height: 20,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: Duration(milliseconds: 280),
                    alignment: value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    curve: Curves.easeOut,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: appColors.surface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isVeg ? appColors.success : appColors.danger,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isVeg ? appColors.success : appColors.danger,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget shimmerCard(double w) {
  return Shimmer.fromColors(
    baseColor: appColors.greyLight,
    highlightColor: appColors.surface,
    period: Duration(seconds: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          width: w,
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(height: 14, width: w * 0.5, color: appColors.surface),
        SizedBox(height: 6),
        Container(height: 12, width: w * 0.35, color: appColors.surface),
        SizedBox(height: 8),
        Container(height: 14, width: w * 0.25, color: appColors.surface),
        SizedBox(height: 8),
        Container(height: 14, width: w * 0.15, color: appColors.surface),
      ],
    ),
  );
}

Widget foodGrid(HomeController homeController, double w) {
  return Obx(() {
    if (homeController.isLoading.value) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 0),
        itemCount: 6,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, __) => shimmerCard(w),
      );
    }

    final selectedCategory =
        homeController.categories[homeController.selectedCategoryIndex.value];
    final items = homeController.thaliItems[selectedCategory] ?? [];

    return GridView.builder(
      itemCount: items.length,
      padding: EdgeInsets.symmetric(horizontal: 0),

      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return GestureDetector(
          onTap: () {
            Get.toNamed(RoutesClass.gotoThaliDetailScreen(), arguments: item);
          },
          child: foodCard(item, homeController, context, w),
        );
      },
    );
  });
}

Widget foodCard(
  Map<String, dynamic> item,
  HomeController controller,
  BuildContext context,
  double w,
) {
  return Container(
    decoration: BoxDecoration(
      color: appColors.surface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: appColors.cardShadow,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),

                child: Image.asset(
                  item['image'],
                  height: 140,
                  width: w,
                  fit: BoxFit.cover,
                ),
              ),

              10.kH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: appColors.textPrimary,
                      ),
                    ),
                    Text(
                      item['description'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: appColors.textMuted,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    2.kH,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: appColors.fab,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: appColors.fab,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: appColors.fab,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: appColors.fab,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                    2.kH,

                    Text(
                      " ₹${item['price']}",
                      style: TextStyle(
                        color: appColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.kH,
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 112,
            left: 127,
            child: GestureDetector(
              onTap: () {
                controller.orderController.addOrder(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${appStrings.addedToOrders} '
                      '${item['name']} ${appStrings.addedSuccessfully}',
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: appColors.surface,
                  border: Border.all(width: 1, color: appColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  appStrings.add,
                  style: TextStyle(
                    color: appColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget thaliCategorySection(HomeController controller) {
  return Obx(() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            customToggle(
              value: controller.veg.value,
              text: appStrings.veg,
              activeColor: appColors.success,
              onChanged: (v) {
                controller.veg.value = v;
                controller.isSpecialSelected.value = false;
                if (v) {
                  controller.nonVeg.value = false;
                  controller.selectedCategoryIndex.value = 1;
                } else if (!controller.nonVeg.value) {
                  controller.selectedCategoryIndex.value = 0;
                }
                controller.startLoading();
              },
            ),
            8.kW,
            customToggle(
              value: controller.nonVeg.value,
              text: appStrings.nonVeg,
              activeColor: appColors.danger,
              onChanged: (v) {
                controller.nonVeg.value = v;
                controller.isSpecialSelected.value = false;
                if (v) {
                  controller.veg.value = false;
                  controller.selectedCategoryIndex.value = 2;
                } else if (!controller.veg.value) {
                  controller.selectedCategoryIndex.value = 0;
                }
                controller.startLoading();
              },
            ),
          ],
        ),

        specialThaliButton(controller),
      ],
    );
  });
}

Widget specialThaliButton(HomeController controller) {
  return Obx(() {
    final isSelected = controller.isSpecialSelected.value;

    return GestureDetector(
      onTap: () {
        if (controller.isSpecialSelected.value) {
          controller.isSpecialSelected.value = false;
          controller.selectedCategoryIndex.value = 0;
          controller.veg.value = false;
          controller.nonVeg.value = false;
        } else {
          controller.isSpecialSelected.value = true;
          controller.selectedCategoryIndex.value = 3;
          controller.veg.value = false;
          controller.nonVeg.value = false;
        }
        controller.startLoading();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? appColors.fab : appColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? appColors.fab : appColors.greyLight,
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? appColors.fab.withOpacity(0.25)
                  : appColors.cardShadow,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rate_rounded,
              size: 18,
              color: isSelected ? appColors.iconOnPrimary : appColors.fab,
            ),
            SizedBox(width: 6),
            Text(
              appStrings.specialThali,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? appColors.iconOnPrimary : appColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget discountScrollSection(HomeController controller) {
  return Container(
    height: 110,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: controller.discounts.length,
      separatorBuilder: (_, __) => SizedBox(width: 12),
      itemBuilder: (context, index) {
        final offer = controller.discounts[index];
        return Container(
          margin: EdgeInsets.only(left: 18),
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage(offer["image"]),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: appColors.surface,
                    child: Icon(offer["icon"], color: offer["color"], size: 26),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer["title"],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: appColors.surface,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          offer["subtitle"],
                          style: TextStyle(fontSize: 13, color: appColors.surface),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

SliverAppBar homeSliverAppBar(
  HomeController controller,
  double w,
  BuildContext context,
) {
  return SliverAppBar(
    backgroundColor: appColors.background,
    elevation: 0,
    pinned: false,
    floating: false,
    toolbarHeight: 0,
    surfaceTintColor: appColors.surface,
    expandedHeight: 105,
    automaticallyImplyLeading: false,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.appBarGradient
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appStrings.yamzi,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: appColors.surface,
                      letterSpacing: 1.2,
                    ),
                  ),

                  Row(
                    children: [
                      roundIcon(
                        Icons.notifications_outlined,
                        () => Get.to(() => NotificationScreen()),
                      ),
                      SizedBox(width: 10),
                      roundIcon(
                        Icons.account_circle_outlined,
                        () => Get.toNamed(RoutesClass.gotoprofileScreen()),
                      ),
                    ],
                  ),
                ],
              ),
              4.kH,
              Obx(()=> Text("${controller.currentAddress}",style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    ),
  );
}


Widget roundIcon(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: appColors.surface.withOpacity(0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: appColors.iconOnPrimary, size: 26),
    ),
  );
}

