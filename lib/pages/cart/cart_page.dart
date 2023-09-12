import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/cart/add_to_page.dart';
import 'package:food_ordering_app/pages/cart/empty_cart.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import 'package:food_ordering_app/widgets/small_text.dart';

import '../../resources/dimension.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> cartItems = List<int>.filled(10, 0);
  List<Map<String, dynamic>> cartItem = [];
  int sum = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            // Navigator.pushNamed(context, Routes.homeScreen);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.orange,
          ),
        ),
        title: const Text(
          "Food  Page",
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: Dimension.height15),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('foods').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final foodItems = snapshot.data!.docs;

              return ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = foodItems[index];
                  final String itemName = foodItem['title'];
                  final String itemDescription = foodItem['description'];
                  final int itemPrice = foodItem['price'];

                  return SizedBox(
                    height: Dimension.height20 * 5,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          width: Dimension.width20 * 5,
                          height: Dimension.height20 * 5,
                          margin: EdgeInsets.only(bottom: Dimension.height10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(foodItem['imageUrl']),
                            ),
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: Dimension.width10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: Dimension.height20 * 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(
                                  text: itemName,
                                  color: Colors.black54,
                                ),
                                SmallText(text: itemDescription),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "Rs.$itemPrice",
                                      color: Colors.redAccent,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: Dimension.height10,
                                        bottom: Dimension.height10,
                                        left: Dimension.width10,
                                        right: Dimension.width10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimension.radius20),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     setState(() {
                                          //       if (cartItems[index] > 0) {
                                          //         setState(() {
                                          //           cartItems[index]--;
                                          //           sum -= itemPrice;
                                          //         });
                                          //       }
                                          //     });
                                          //   },
                                          //   child: const Icon(
                                          //     Icons.remove,
                                          //     color: AppColors.colorBlue,
                                          //   ),
                                          // ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (cartItems[index] > 0) {
                                                  cartItems[index]--;
                                                  sum -= itemPrice;
                                                  cartItem.removeWhere((item) =>
                                                      item['itemName'] ==
                                                          itemName &&
                                                      item['itemDescription'] ==
                                                          itemDescription &&
                                                      item['itemPrice'] ==
                                                          itemPrice);
                                                }
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: AppColors.colorBlue,
                                            ),
                                          ),

                                          BigText(
                                            text: cartItems[index].toString(),
                                          ),
                                          SizedBox(
                                            width: Dimension.width5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                cartItems[index]++;
                                                sum += itemPrice;
                                                cartItem.add({
                                                  'imageUrl':
                                                      foodItem['imageUrl'],
                                                  'itemName': itemName,
                                                  'itemDescription':
                                                      itemDescription,
                                                  'itemPrice': itemPrice,
                                                });
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: AppColors.colorBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Dimension.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimension.height30,
          bottom: Dimension.height30,
          left: Dimension.width20,
          right: Dimension.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyShade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.radius40),
            topRight: Radius.circular(Dimension.radius40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimension.height10,
                bottom: Dimension.height10,
                left: Dimension.width10,
                right: Dimension.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: AppColors.blackColor,
              ),
              child: Row(
                children: [
                  BigText(
                    text: cartItems.reduce((a, b) => a + b).toString(),
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            Container(
              width: 210,
              padding: EdgeInsets.only(
                top: Dimension.height10,
                bottom: Dimension.height10,
                left: Dimension.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: AppColors.blackColor,
              ),
              child: Row(
                children: [
                  const Text(
                    'Total NPR    ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  BigText(
                    text: sum.toString(),
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (cartItem.isEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NoDataPage(
                        text: 'No items available',
                      ),
                    ),
                  );
                } else {
                  FirebaseFirestore.instance
                      .collection(
                          'orders') // Replace 'orders' with your desired collection name
                      .add({
                    // 'cartItems': cartItem,
                    'total': sum,
                    // 'timestamp': DateTime.now(),
                    // 'cart_item_count': cartItem,

                    'foodName':
                        cartItem.map((item) => item['itemName']).toList(),
                    'location':
                        "Nilbarahi marg, Paropakar, कालिमाटी, काठमाडौं, काठमाडौँ महानगरपालिका, काठमाडौं, Bagmati Pradesh, 44000, नेपाल",

                    'timestamp': DateTime.now(),
                    // orderId: value.id, // Pass the generated orderId to the AddToCartPage
                  }).then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddToCartPage(
                          cartItem: cartItem,
                          total: sum,
                          cartItems: const [],
                          // Pass the generated orderId to the AddToCartPage
                        ),
                      ),
                    );
                  }).catchError((error) {
                    print('Error storing cart items: $error');
                    // Handle error while storing cart items in Firebase
                    // ...
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimension.height10,
                  bottom: Dimension.height10,
                  left: Dimension.width10,
                  right: Dimension.width10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: AppColors.blackColor,
                ),
                child: BigText(
                  text: "Check Out",
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
