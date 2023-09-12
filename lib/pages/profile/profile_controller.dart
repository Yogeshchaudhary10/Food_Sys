import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';

class ProfileController with ChangeNotifier {
  void pickeImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.camera,
                      color: AppColors.blackColor,
                    ),
                    title: const Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.image,
                      color: AppColors.blackColor,
                    ),
                    title: const Text("Gallery"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
