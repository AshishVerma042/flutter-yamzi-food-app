import 'package:get/get.dart';
import 'orderController.dart';

class CustomizationController extends GetxController {
  final OrderController orderController = Get.put(OrderController());
  var showShimmer = true.obs;
  var selectedThaliType = 'Vegetarian'.obs;
  var selectedItems = <String, int>{}.obs;
  var totalPrice = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    triggerShimmer();
  }
  void triggerShimmer() {
    showShimmer.value = true;
    Future.delayed(Duration(seconds: 2), () {
      showShimmer.value = false;
    });
  }


  final List<Map<String, dynamic>> allMenuItems = [
    {
      'id': 'item_102',
      'name': 'Chicken Tandoori',
      'category': 'non-vegetarian',
      'type': 'curry',
      'price': 110,
      'imageUrl': 'assets/images/nonVeg (2).jpg',
      'description': 'Grilled tandoori chicken',
    },
    {
      'id': 'item_007',
      'name': 'Dal Makhani',
      'category': 'vegetarian',
      'type': 'curry',
      'price': 80,
      'imageUrl': 'assets/images/sabji (1).jpg',
      'description': 'Creamy lentil curry',
    },
     {
      "id": 'item_008',
      "name": 'Paneer Tikka Masala',
      "category": 'vegetarian',
      "type": 'curry',
      "price": 100,
      "imageUrl": 'assets/images/sabji (3).jpg',
      "description": 'Paneer in tomato gravy',
     },
{
      "id": 'item_001',
      "name": 'Basmati Rice',
      "category": 'vegetarian',
      "type": 'rice',
      "price": 40,
      "imageUrl": 'assets/images/rice1.jpg',
      "description": 'Fragrant basmati rice',
},
{
      "id": 'item_002',
      "name": 'Steamed Rice',
      "category": 'vegetarian',
      "type": 'rice',
      "price": 35,
      "imageUrl": 'assets/images/rice3.jpg',
      "description": 'Plain steamed rice',
},
{
      "id": 'item_003',
      "name": 'Jeera Rice',
      "category": 'vegetarian',
      "type": 'rice',
      "price": 45,
      "imageUrl": 'assets/images/rice2.jpg',
      "description": 'Rice with cumin seeds',
},
{
      "id": 'item_004',
      "name": 'Wheat Roti',
      "category": 'vegetarian',
      "type": 'roti',
      "price": 10,
      "imageUrl": 'assets/images/roti1.jpg',
      "description": 'Soft wheat bread',
},
{
      "id": 'item_005',
      "name": 'Paratha',
      "category": 'vegetarian',
      "type": 'roti',
      "price": 20,
      "imageUrl": 'assets/images/roti3.jpg',
      "description": 'Stuffed flatbread',
},
{
      "id": 'item_006',
      "name": 'Naan',
      "category": 'vegetarian',
      "type": 'roti',
      'price': 25,
      "imageUrl": 'assets/images/roti2.jpg',
      "description": 'Tandoori naan bread',
},
{
      "id": 'item_009',
      "name": 'Aloo Gobi',
      "category": 'vegetarian',
      "type": 'sabzi',
      "price": 60,
      "imageUrl": 'assets/images/sabji (2).jpg',
      "description": 'Potato and cauliflower',
},
{
      "id": 'item_010',
      "name": 'Mixed Vegetables',
      'category': 'vegetarian',
      'type': 'sabzi',
      'price': 65,
      'imageUrl': 'assets/images/sabji (4).jpg',
      'description': 'Seasonal vegetables',
},
{
      'id': 'item_011',
      'name': 'Garden Salad',
      'category': 'vegetarian',
      'type': 'salad',
      'price': 40,
      'imageUrl': 'assets/images/salad.jpg',
      'description': 'Fresh vegetables',
},
{
      'id': 'item_012',
      'name': 'Curd (Yogurt)',
      'category': 'vegetarian',
      'type': 'side',
      'price': 30,
      'imageUrl': 'assets/images/yogurt.jpg',
      'description': 'Fresh yogurt',
},
{
      'id': 'item_013',
      'name': 'Pickle',
      'category': 'vegetarian',
      'type': 'side',
      'price': 15,
      'imageUrl': 'assets/images/pickle.jpeg',
      'description': 'Spiced pickle',
},

    // Non-Vegetarian Items
    {
      'id': 'item_101',
      'name': 'Butter Chicken',
      'category': 'non-vegetarian',
      'type': 'curry',
      'price': 120,
      'imageUrl': 'assets/images/nonVeg (3).jpg',
      'description': 'Tender chicken in cream sauce',
},
{
      'id': 'item_103',
      'name': 'Mutton Curry',
      'category': 'non-vegetarian',
      'type': 'curry',
      'price': 130,
      'imageUrl': 'assets/images/nonVeg (4).jpg',
      'description': 'Spiced mutton',
},
{
      'id': 'item_104',
      'name': 'Fish Curry',
      'category': 'non-vegetarian',
      'type': 'curry',
      'price': 125,
      'imageUrl': 'assets/images/nonVeg (1).jpg',
      'description': 'Fresh fish in spices',
},
{
      'id': 'item_105',
      'name': 'Egg Curry',
      'category': 'non-vegetarian',
      'type': 'curry',
      'price': 85,
      'imageUrl': 'assets/images/nonVeg (15).jpg',
      'description': 'Eggs in gravy',
},
{
'id': 'item_106',
'name': 'Chicken Kebab',
'category': 'non-vegetarian',
'type': 'side',
'price': 90,
'imageUrl': 'assets/images/nonVeg (5).jpg',
'description': 'Grilled chicken kebab',
},

  ];

  List<Map<String, dynamic>> getAvailableItems() {
    if (selectedThaliType.value == 'Vegetarian') {
      return allMenuItems
          .where((item) =>
      item['category'] == 'vegetarian' || item['category'] == 'all')
          .toList();
    } else if (selectedThaliType.value == 'Non-Vegetarian') {
      return allMenuItems
          .where((item) =>
      item['category'] == 'non-vegetarian' ||
          item['category'] == 'all' ||
          item['type'] == 'rice' ||
          item['type'] == 'roti')
          .toList();
    } else {
      return allMenuItems;
    }
  }

  void addItem(String itemId) {
    if (selectedItems.containsKey(itemId)) {
      selectedItems[itemId] = selectedItems[itemId]! + 1;
    } else {
      selectedItems[itemId] = 1;
    }
    calculateTotal();
  }

  void removeItem(String itemId) {
    if (selectedItems.containsKey(itemId)) {
      if (selectedItems[itemId]! > 1) {
        selectedItems[itemId] = selectedItems[itemId]! - 1;
      } else {
        selectedItems.remove(itemId);
      }
    }
    calculateTotal();
  }

  void calculateTotal() {
    double total = 0;
    selectedItems.forEach((itemId, quantity) {
      final item =
      allMenuItems.firstWhere((item) => item['id'] == itemId);
      total += item['price'] * quantity;
    });
    totalPrice.value = total;
  }

  List<Map<String, dynamic>> getSelectedItemsDetails() {
    List<Map<String, dynamic>> details = [];
    selectedItems.forEach((itemId, quantity) {
      final item = allMenuItems.firstWhere((item) => item['id'] == itemId);
      details.add({
        'name': item['name'],
        'quantity': quantity,
        'price': item['price'],
        'total': item['price'] * quantity,
      });
    });
    return details;
  }

  void resetCustomization() {
    selectedThaliType.value = 'Vegetarian';
    selectedItems.clear();
    totalPrice.value = 0;
  }
}
