import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/payment/defaultButton.dart';
import 'package:food_ordering_app/pages/profile/profile_screen.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/widgets/emptySection.dart';
import 'package:food_ordering_app/widgets/subTitle.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptySection(
            emptyMsg: 'Successful !!',
            emptyImg: '',
          ),
          const SubTitle(
            subTitleText: 'Your payment was done successfully',
          ),
          DefaultButton(
            btnText: 'Ok',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
