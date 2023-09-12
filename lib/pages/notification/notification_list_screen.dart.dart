import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const Text(
          "Notification",
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        leading: IconButton(
          color: AppColors.blackColor,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.popAndPushNamed(context, Routes.homeScreen);
          },
        ),
      ),
      body: ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 35,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: Dimension.height10 * 5,
              width: Dimension.height10 * 5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/food_shopping_logo.png"),
                      fit: BoxFit.cover)),
            ),
            title: const Text(
              "food Orderinng",
              style: TextStyle(color: AppColors.blackColor),
            ),
            subtitle: const Text(
              "Thank you for order",
              style: TextStyle(color: AppColors.primary),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.notificationPage);
            },
            enabled: true,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
