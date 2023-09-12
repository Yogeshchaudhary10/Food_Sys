import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
            Navigator.pushNamed(context, Routes.notificationList);
          },
        ),
      ),
      body: FittedBox(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.homeScreen);
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(100),
            padding: const EdgeInsets.all(100),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2.0)]),
            child: Column(
              children: [
                const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    style: TextStyle()),
                const SizedBox(height: 16.0),
                const Image(
                  image: AssetImage("assets/images/burger.png"),
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                const Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                    style: TextStyle(color: AppColors.blackColor)),
                SizedBox(height: Dimension.height10 * 1.6),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('11/Feb/2021 04:42 PM',
                      style: TextStyle(color: Colors.red)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
