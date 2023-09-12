import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/cart/empty_cart.dart';
import 'package:food_ordering_app/pages/combine_page_for_map_and_payment/combine.dart';
import 'package:food_ordering_app/pages/models/food.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/widgets/app_icon.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import '../../resources/dimension.dart';
import '../../widgets/expandable_text__widget.dart';

class RecommenededFoodDetail extends StatefulWidget {
  final Food food;

  const RecommenededFoodDetail({Key? key, required this.food})
      : super(key: key);

  @override
  State<RecommenededFoodDetail> createState() => _RecommenededFoodDetailState();
}

class _RecommenededFoodDetailState extends State<RecommenededFoodDetail> {
  int cartItem = 0;
  double sum = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void placeOrder() async {
    try {
      // Create a new document in the "orders" collection
      await firestore.collection('orders').add({
        'food_name': widget.food.title,
        'food_price': widget.food.price,
        'cart_item_count': cartItem,
        'total_sum': sum,
        'location':
            "Nilbarahi marg, Paropakar, कालिमाटी, काठमाडौं, काठमाडौँ महानगरपालिका, काठमाडौं, Bagmati Pradesh, 44000, नेपाल",
        'timestamp': DateTime.now(),
        // Add other fields as needed
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CombinedPage(),
        ),
      );
    } catch (e) {
      print('Error placing order: $e');
      // Handle the error, show a snackbar, or display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            // title: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // AppIcon(
            //     //   icon: Icons.arrow_back_ios,
            //     //   background: AppColors.primaryColor,
            //     //   iconSize: Dimension.iconSize16,
            //     // ),
            //     // AppIcon(
            //     //   icon: Icons.shopping_cart_outlined,
            //     //   background: AppColors.primaryColor,
            //     //   iconSize: Dimension.iconSize16,
            //     // ),
            //   ],
            // ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimension.radius20),
                          topRight: Radius.circular(Dimension.radius20))),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                  ),
                  child: Center(
                      child: BigText(
                    size: Dimension.font26,
                    text: widget.food.title,
                    // String: String
                  )),
                )),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.food.image,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimension.width20,
                    right: Dimension.width20,
                  ),
                  child: ExpandableTextWidget(text: widget.food.detail),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimension.width20 * 2.5,
              right: Dimension.width20 * 2.5,
              top: Dimension.height10,
              bottom: Dimension.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (cartItem > 0) {
                        setState(() {
                          cartItem--;
                          sum -= widget.food.price.toDouble();
                        });
                      }
                    });
                  },
                  child: AppIcon(
                    background: AppColors.colorBlue,
                    icon: Icons.remove,
                    iconSize: Dimension.iconSize24,
                  ),
                ),
                BigText(
                  text: " Rs.${widget.food.price} X $cartItem",
                  color: AppColors.blackColor,
                  size: Dimension.font26,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cartItem++;
                      sum += widget.food.price.toDouble();
                    });
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    background: AppColors.blackColor,
                    iconSize: Dimension.iconSize24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Dimension.bottomHeightBar,
            padding: EdgeInsets.symmetric(
              vertical: Dimension.height30,
              horizontal: Dimension.width20,
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
                  width: 150,
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
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      BigText(
                        text: sum.toString(),
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimension.width10 * 1.2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: AppColors.blackColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (cartItem == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoDataPage(
                              text: '',
                            ),
                          ),
                        );
                      } else {
                        placeOrder(); // Call placeOrder() when checking out
                      }
                    },
                    child: BigText(
                      text: "Check Out",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
