import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yamzi/Modules/screens/customThaliManagement/Customization_Thali.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/resources/strings.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../controllers/orderController.dart';

class OrderScreen extends ParentWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar:  appBar(appStrings.cart),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return  SizedBox(height: h*0.7,
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Lottie.asset(
                "assets/lottie/Shoppp.json",
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
                  Text(
                    appStrings.noOrdersYet,
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  GestureDetector(
                    child: Container(decoration: BoxDecoration(color: Colors.orange),
                      child: Text("Explore more",),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        orderController.calculateTotal();

        return Padding(
          padding:  EdgeInsets.only( top: 10,left: 12,right: 12),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(padding: EdgeInsets.only(bottom: 40),
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  itemCount: orderController.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderController.orders[index];
                    final isCustomized = order['source'] == 'CustomizationScreen';
                    final quantity = order['quantity'] ?? 1;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset:  Offset(0, 2),
                          ),
                        ],
                      ),
                      margin:
                       EdgeInsets.symmetric( vertical: 8),
                      padding:  EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  isCustomized
                                      ? '${appStrings.customizedThali} (${order['thaliType']})'
                                      : order['name'],
                                  style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  qtyButton(
                                     Icons.remove,
                                     () => orderController
                                        .decreaseQuantity(index),
                                  ),
                                  6.kW,
                                  Text(
                                    '$quantity',
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  6.kW,
                                  qtyButton(
                                     Icons.add,
                                    () =>
                                        orderController.increaseQuantity(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          6.kH,
                          Obx(()=> AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: ClipRect(
                                child: orderController.expandedCards[index]
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    8.kH,

                                    if (isCustomized)
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: (order['items'] as List).length,
                                        itemBuilder: (context, i) {
                                          final item = order['items'][i];
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${item['name']} x ${item['quantity']}",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              Text(
                                                "₹${item['total']}",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ],
                                          );
                                        },
                                      ),

                                    if (isCustomized== false)
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: order['includes'].length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Text(
                                              "${order['includes'][i]}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          );
                                        },
                                      ),

                                    10.kH,
                                  ],
                                )
                                    : SizedBox.shrink(),
                              ),
                            ),
                          ),

                          Obx(()=> GestureDetector(
                              onTap: () => orderController.toggleExpand(index),
                              child: Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text(
                                  orderController.expandedCards[index]
                                      ? "Hide Details"
                                      : "View Details",
                                  style: TextStyle(
                                    color: appColors.textMuted,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Text(
                  appStrings.youMayAlsoLike,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      suggestionCard("Wheat roti", "₹79", "assets/images/roti1.jpg"),
                      suggestionCard("Paneer Butter Masala", "₹199", "assets/images/sabji (2).jpg"),
                      suggestionCard("Yogurt", "₹99", "assets/images/yogurt.jpg"),
                      suggestionCard("Veg Biryani", "₹149", "assets/images/nonVeg (11).jpg"),
                    ],
                  ),
                ),
                orderSummary(orderController)
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(
            () => Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: orderController.orders.isEmpty ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: Text(
              "Continue to Payment  ₹${orderController.totalPrice.value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 17, color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

    );
  }

  Widget qtyButton( IconData icon,  VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange.shade300, width: 1),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding:  EdgeInsets.all(4),
        child: Icon(icon, color: Colors.orange, size: 14),
      ),
    );
  }
}

Widget suggestionCard(String name, String price, String imagePath) {
  return Container(padding: EdgeInsets.symmetric(vertical: 6),
    width: 120,
    margin:  EdgeInsets.only(right: 12,bottom: 2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 4,
          offset:  Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            height: 70,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
         6.kH,
        Text(
          name,
          style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          price,
          style:  TextStyle(color: Colors.orange, fontSize: 13),
        ),
      ],
    ),
  );
}

Widget orderSummary(OrderController orderController){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appStrings.orderSummary,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18),
      ),
      8.kH,
      ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        physics:  NeverScrollableScrollPhysics(),
        itemCount: orderController.orders.length,
        itemBuilder: (context, index) {
          final order = orderController.orders[index];
          final isCustomized =
              order['source'] == 'CustomizationScreen';
          final quantity = order['quantity'] ?? 1;
          final total = isCustomized
              ? order['totalPrice'] * quantity
              : order['price'] * quantity;

          return Padding(
            padding:
             EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isCustomized
                        ? '${appStrings.customizedThali} (${order['thaliType']}) x$quantity'
                        : '${order['name']} x$quantity',
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '₹${total.toStringAsFixed(2)}',
                  style:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      8.kH,

      Container(
        padding:  EdgeInsets.symmetric(
            horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appStrings.total,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "₹${orderController.totalPrice.value.toStringAsFixed(2)}",
              style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  );
}