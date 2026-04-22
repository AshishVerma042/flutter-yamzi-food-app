import 'package:get/get.dart';

class OrderController extends GetxController {

  var orders = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;

  RxList<bool> expandedCards = <bool>[].obs;

  void initExpandedList() {
    while (expandedCards.length < orders.length) {
      expandedCards.add(false);
    }
  }


  void toggleExpand(int index) {
    expandedCards[index] = !expandedCards[index];
    expandedCards.refresh();
  }



  void calculateTotal() {
    double total = 0.0;
    for (var order in orders) {
      final quantity = order['quantity'] ?? 1;
      if (order['source'] == 'CustomizationScreen') {
        total += (order['totalPrice'] ?? 0) * quantity;
      } else {
        total += (order['price'] ?? 0) * quantity;
      }
    }

    totalPrice.value = total;
  }


  void addOrder(Map<String, dynamic> item) {
    final newOrder = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'source': 'HomeScreen',
      'name': item['name'],
      'image': item['image'],
      'price': item['price'],
      'rating': item['rating'],
      'includes': List<String>.from(item['includes']),
      'quantity': 1,
      'time': DateTime.now().toString(),
    };
    orders.add(newOrder);
    initExpandedList();
  }

  void addCustomizedOrder({
    required String thaliType,
    required List<Map<String, dynamic>> items,
    required double totalPrice,
  }) {
    final newOrder = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'source': 'CustomizationScreen',
      'thaliType': thaliType,
      'items': items,
      'totalPrice': totalPrice,
      'quantity': 1,
      'time': DateTime.now().toString(),
    };
    orders.add(newOrder);
    initExpandedList();
  }
  void removeItem(int index){
    orders.removeAt(index);
    expandedCards.removeAt(index);
  }

  void increaseQuantity(int index) {
    orders[index]['quantity'] = (orders[index]['quantity'] ?? 1) + 1;
    orders.refresh();
    calculateTotal();

  }

  void decreaseQuantity(int index) {
    if (orders[index]['quantity'] > 1) {
      orders[index]['quantity'] = orders[index]['quantity'] - 1;
    } else {
      orders.removeAt(index);
    }
    orders.refresh();
    calculateTotal();
  }


  void clearOrders() {
    orders.clear();
  }
}
