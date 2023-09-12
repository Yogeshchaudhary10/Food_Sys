import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key, this.total = 0}) : super(key: key);
  final int total;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String referenceId = "";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                payWithKhaltiInApp();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.blackColor),
              ),
              child: const Text("Pay with Khalti"),
            ),
            Text(referenceId),
          ],
        ),
      ),
    );
  }

  payWithKhaltiInApp() {
    print(widget.total);
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        // amount: widget.total * 100, //in paisa
        amount: 1000, //in paisa

        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            SimpleDialogOption(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  referenceId = success.idx;
                });

                // Store payment history in Firestore
                firestore.collection('payment_history').add({
                  'referenceId': success.idx,
                  'amount': 1000, // Add more fields as needed
                  'timestamp': FieldValue.serverTimestamp(),
                });

                Navigator.pushNamed(context, Routes.homeScreen);
              },
            )
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}
