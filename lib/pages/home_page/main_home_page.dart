import 'package:flutter/material.dart';

import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import 'package:food_ordering_app/widgets/small_text.dart';

import '../../resources/dimension.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Column(
        children: [
          // showing  the header

          Container(
            margin: EdgeInsets.only(
              top: Dimension.height45,
              bottom: Dimension.height15,
            ),
            padding: EdgeInsets.only(
              left: Dimension.width20,
              right: Dimension.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Nepal",
                      color: AppColors.orange,
                      // String: null,
                      // BigText is a custome widget and reusable widget
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "Kathmandu",
                          color: AppColors
                              .smallTextColor, // SmallText wedget is also reusable widget
                        ),
                        // const Icon(Icons.arrow_drop_down_rounded),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.searchPage);
                  },
                  child: Container(
                    width: Dimension.height45,
                    height: Dimension.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimension.radius15,
                      ),
                      color: AppColors.blackColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimension.iconSize24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //showing the body
          const Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      ),
    );
  }
}
