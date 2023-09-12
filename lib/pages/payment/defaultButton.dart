import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  final TextStyle textStyle;
  final Color disabledColor;
  const DefaultButton({
    Key? key,
    required this.btnText,
    required this.onPressed,
    this.textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.disabledColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 24.4),
      padding: const EdgeInsets.symmetric(horizontal: 24.4),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledColor;
            }
            return AppColors.orange;
          }),
        ),
        onPressed: () {},
        child: Text(
          btnText.toUpperCase(),
          style: textStyle.copyWith(color: AppColors.blackColor),
        ),
      ),
    );
  }
}
