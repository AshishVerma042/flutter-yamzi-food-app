import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yamzi/main.dart';
import 'package:yamzi/resources/colors.dart';
import 'package:yamzi/utils/sized_box_extension.dart';
import '../../../resources/strings.dart';
import '../../../routes/RoutesClass.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/thali_details_controller.dart';
import '../customThaliManagement/Customization_Thali.dart';

class ThaliDetailScreen extends ParentWidget {
   ThaliDetailScreen({super.key,});

  final ThaliDetailController controller = Get.put(ThaliDetailController());

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: appBar(controller.item['name'],controller: controller,trailingIcon: true),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             thaliPreview(controller),
             20.kW,
            thaliTital(controller),
             16.kH,
            thaliIteamDetail(w, controller),
            20.kH,
            Text(
              "Similar Thali",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            10.kH,

            suggestionFoodGrid( controller.homeController, w,controller.item),

          ],
        ),
      ),
      bottomNavigationBar: bottomPriceBar(controller),
    );
  }
}


Widget  bottomPriceBar(dynamic controller){
  return BottomAppBar(
      color: appColors.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.item['name'],style: TextStyle(fontSize: 9),),
              Text(
                "₹${controller.item['price']}",
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appColors.textPrimary,
                ),
              ),
              Text("Inclusive of all taxes",style: TextStyle(color: appColors.textMuted,fontSize: 9),)
            ],
          ),

          addToCartButton(controller)

        ],
      )
  );
}
Widget addToCartButton (dynamic controller){
  return GestureDetector(onTap: () {
    controller.homeController.orderController.addOrder(controller.item);
    Get.back();
  },
    child: Container(padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: appColors.fab,borderRadius: BorderRadius.circular(8)),
      child: Text("Add to Cart",style: TextStyle(color: appColors.surface, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
Widget thaliPreview(dynamic controller){
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        child: Image.asset(
          controller.item['image'],
          width: double.infinity,
          height: 280,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(bottom: -4,left: -2,child: Container(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),decoration: BoxDecoration(color: appColors.surface,borderRadius: BorderRadius.circular(6)),
        child: Row(children: [
          Icon(Icons.access_time,color: appColors.success,size: 14,),
          4.kW,
          Text(
            "${controller.item['preparationTime']}",
            style:  TextStyle(fontSize: 10,color: appColors.textPrimary),
          ),
          6.kW,

          Icon(Icons.star,color: appColors.fab,size: 14,),
          Icon(Icons.star,color: appColors.fab,size: 14,),
          Icon(Icons.star,color: appColors.fab,size: 14,),
          Icon(Icons.star,color: appColors.fab,size: 14,),

        ],),
      ),)
    ],
  );
}
Widget thaliTital(dynamic controller){
  return Container(padding: EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: appColors.surface,borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.kH,

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.item['name'],
              style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Container(padding: EdgeInsets.all(3),width: 18,height: 18,decoration: BoxDecoration(border: Border.all(width: 1.5,color: controller.item['isVegetarian']?appColors.success: appColors.danger),borderRadius: BorderRadius.circular(4))
              ,child:Container(width: 4,height: 4,decoration: BoxDecoration(color: controller.item['isVegetarian']? appColors.success: appColors.danger,borderRadius: BorderRadius.circular(9)))
              ,
            )
          ],
        ),
        5.kH,

        Text(
          controller.item['description'],
          style:  TextStyle(fontSize: 14, color: appColors.textMuted),
        ),
        10.kH,
      ],
    ),
  );
}
Widget thaliIteamDetail(double w,dynamic controller){
  return Container(
    width: w,padding: EdgeInsets.symmetric(horizontal: 16),decoration: BoxDecoration(color: appColors.surface,borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Thali Items Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),


        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                for (var include in controller.item['includes'])
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      "• $include",
                      style:  TextStyle(fontSize: 15),
                    ),
                  ),
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Lottie.asset(
                      "assets/lottie/flame.json",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Positioned(bottom: 5,left: 45,
                      child: Text(
                        "${controller.item['calories']} kcal",
                        style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                20.kH
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget suggestionFoodGrid(HomeController homeController,double w,Map<String, dynamic> item){
  final selectedCategory = item['isVegetarian']?'Vegetarian':'Non-Vegetarian';
  final items = homeController.thaliItems[selectedCategory] ?? [];
     return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(onTap: (){
          Get.toNamed(
            RoutesClass.thaliDetailScreen,
            arguments: item,
            preventDuplicates: false,
          );

        },
          child: Container(
            decoration: BoxDecoration(
              color: appColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: appColors.cardShadow,
                  blurRadius: 6,
                  offset:  Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
              child: Stack(
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16) ),
                          child: Image.asset(item['image'],height: 140,width: w, fit: BoxFit.cover)),

                      10.kH,
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'],maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14,)),
                            Text(item['description'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:  TextStyle(color: appColors.textMuted,
                                  fontWeight: FontWeight.w400, fontSize: 12,)),
                            2.kH,

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,color: appColors.fab,size: 18,),
                                    Icon(Icons.star,color: appColors.fab,size: 18,),
                                    Icon(Icons.star,color: appColors.fab,size: 18,),
                                    Icon(Icons.star,color: appColors.fab,size: 18,),

                                  ],
                                ),
                              ],
                            ),
                            2.kH,

                            Text(" ₹${item['price']}",
                                style: TextStyle(
                                    color: appColors.textPrimary,
                                    fontWeight: FontWeight.bold)),
                            10.kH,

                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(top: 112,left: 127,
                      child: GestureDetector(onTap: (){
                        homeController.orderController.addOrder(item);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${appStrings.addedToOrders} '
                            '${item['name']} ${appStrings.addedSuccessfully}')),
                      );},
                        child: Container(padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),decoration: BoxDecoration(
                            color: appColors.surface,
                            border: Border.all(width: 1,color: appColors.primary),
                            borderRadius: BorderRadius.circular(10)),
                          child: Text('ADD',style: TextStyle(color: appColors.primaryDark,fontWeight: FontWeight.bold),),),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
}

