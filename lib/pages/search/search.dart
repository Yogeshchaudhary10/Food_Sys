import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/cart/empty_cart.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

import '../../category_screen/category_screen.dart';
import '../../resources/color_manager.dart';
import '../../resources/dimension.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text__widget.dart';
import '../combine_page_for_map_and_payment/combine.dart';
import '../models/Data/search_food_list.dart';
import '../models/search_food.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  List<String> foodCategories = [
    'Burgers',
    'Pizzas',
    'Sushi',
    'Pasta',
    'Salads',
  ];

  List<FoodItem> searchResults = [];

  List<FoodItem> getFoodItems() {
    if (searchResults.isEmpty) {
      // If the search results are empty, show all popular and newest food items
      return [...popularFoodItems, ...newestFoodItems];
    } else {
      // Show the search results
      return searchResults;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const Text(
          'Food Search',
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.homeScreen);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  if (query.isEmpty) {
                    // Reset the search results when the query is empty
                    searchResults = [];
                  } else {
                    // Filter popular and newest food items based on the query
                    searchResults = [...popularFoodItems, ...newestFoodItems]
                        .where((food) => food.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search for food',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Food Categories',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodCategories.length,
              itemBuilder: (context, index) {
                final category = foodCategories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          category: category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(category),
                    ),
                  ),
                );
              },
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     'Popular Food',
          //     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // SizedBox(
          //   height: 200.0,
          //   child: PageView.builder(
          //     itemCount: getFoodItems().length,
          //     itemBuilder: (context, index) {
          //       final foodItem = getFoodItems()[index];
          //       return Card(
          //         child: ListTile(
          //           leading: Container(
          //             child: Image.network(
          //               foodItem.image,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           title: Text(foodItem.name),
          //           subtitle: Text(
          //             foodItem.isAvailable ? 'Available' : 'Not Available',
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Searched Food',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFoodItems().length,
              itemBuilder: (context, index) {
                final foodItem = getFoodItems()[index];
                return GestureDetector(
                  onTap: () {
                    if (foodItem.isAvailable) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FoodDetailsPage(foodItem: foodItem),
                        ),
                      );
                    }
                  },
                  child: ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(foodItem.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(foodItem.name),
                    subtitle: Text(
                      foodItem.isAvailable ? 'Available' : 'Not Available',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FoodDetailsPage extends StatefulWidget {
  final FoodItem foodItem;

  const FoodDetailsPage({
    required this.foodItem,
    Key? key,
  }) : super(key: key);

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int cartItem = 0;
  double sum = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20),
                    topRight: Radius.circular(Dimension.radius20),
                  ),
                ),
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                child: Center(
                  child: BigText(
                    size: Dimension.font26,
                    text: widget.foodItem.title,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.foodItem.image,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimension.width20,
                  ),
                  child: ExpandableTextWidget(text: widget.foodItem.detail),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimension.width20 * 2.5,
              right: Dimension.width20 * 2.5,
              top: Dimension.width20,
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
                          sum -= widget.foodItem.price.toDouble();
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
                  text: " Rs.${widget.foodItem.price} X $cartItem",
                  color: AppColors.blackColor,
                  size: Dimension.font26,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cartItem++;
                      sum += widget.foodItem.price.toDouble();
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
                        // Create a new document in the "orders" collection
                        firestore.collection('orders').add({
                          'food_title': widget.foodItem.title,
                          'food_price': widget.foodItem.price,
                          // Add more fields as needed
                          'cart_item_count': cartItem,
                          'total_sum': sum,
                        });

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CombinedPage(),
                          ),
                        );
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
