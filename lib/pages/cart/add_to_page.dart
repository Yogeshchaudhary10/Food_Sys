import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/combine_page_for_map_and_payment/combine.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import 'package:food_ordering_app/widgets/small_text.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage(
      {super.key,
      this.cartItem,
      this.total,
      required List<Map<String, dynamic>> cartItems});
  final List<Map<String, dynamic>>? cartItem;
  final int? total;

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  // List<Map<String, dynamic>> cartItems = [];

  // void addToCart(String item) {
  //   setState(() {
  //     cartItems.add(item);
  //   });
  // }

  // void removeFromCart(String item) {
  //   setState(() {
  //     cartItems.remove(item);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    log(widget.cartItem.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const Text(
          'Add to Cart',
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.homeScreen);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 246, 246, 246),
        child: widget.cartItem != null && widget.total != null
            ? ListView.builder(
                itemCount: widget.cartItem!.length,
                itemBuilder: (context, index) {
                  print(widget.cartItem);
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
                              image: NetworkImage(
                                  widget.cartItem![index]['imageUrl'] ?? ''),
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
                                  text: widget.cartItem![index]['itemName'],
                                  color: Colors.black54,
                                ),
                                SmallText(
                                    text: widget.cartItem![index]
                                        ['itemDescription']),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text:
                                          "Rs.${widget.cartItem![index]['itemPrice']}",
                                      color: Colors.redAccent,
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
              )
            : const SizedBox(),
      ),

      // ListView.builder(
      //   itemCount: cartItems.length,
      //   itemBuilder: (context, index) {
      //     final item = cartItems[index];
      //     return ListTile(
      //       title: Text(item),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.delete),
      //         onPressed: () => removeFromCart(item),
      //       ),
      //     );
      //   },
      // ),
      bottomNavigationBar: SizedBox(
        // width: double.infinity,
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          margin: const EdgeInsets.only(
              bottom: 20), // Adjust the top margin as needed
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Checkout'),
                      content: const Text('Proceed with checkout?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Confirm'),
                          onPressed: () {
                            // Perform the actual checkout operation
                            // ...
                            // Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CombinedPage(total: widget.total!),
                              ),
                            );

                            // Show success message or navigate to success page
                            // ...
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.blackColor),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ),
    );
  }
}
