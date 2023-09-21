import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String location = "Pick  a location";
  double latitude = 27.700769, longitude = 85.300140;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.orange,
      //   title: Text(
      //     "Address Page",
      //     style: TextStyle(color: AppColors.blackColor),
      //   ),
      //   centerTitle: true,
      //   leading: IconButton(
      //     onPressed: () {
      //       // Navigator.pushNamed(context, Routes.cartPage);
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (context) => CombinedPage()));
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: AppColors.blackColor,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //     child: Text(location),
              //     onTap: () {
              //       _showModal(context);
              //     }),
              // InkWell(
              //     child: Text(location),
              //     onTap: () {
              //       _showModal(context);
              //     }),
              ElevatedButton(
                onPressed: () {
                  _showModal(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.blackColor),
                ),
                child: Text(location),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 800,
          color: AppColors.blackColor,
          child: Center(
            child: OpenStreetMapSearchAndPick(
              center: LatLong(latitude, longitude),
              buttonColor: AppColors.blackColor,
              buttonText: ' Current Location',
              onPicked: (pickedData) async {
                Navigator.pop(context);
                setState(() {
                  location = pickedData.address;
                  latitude = pickedData.latLong.latitude;
                  longitude = pickedData.latLong.longitude;
                });

                // try {
                //   final user = FirebaseAuth.instance.currentUser;

                //   // Create a new order document in the 'orders' collection
                //   final orderRef = _firestore.collection('orders').doc();

                //   // Set the order details including the picked location
                //   await orderRef.set({
                //     'userId': user?.uid,
                //     'location': pickedData.address,
                //     'latitude': pickedData.latLong.latitude,
                //     'longitude': pickedData.latLong.longitude,
                //     // Add other order details as needed
                //   });

                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Order placed successfully'),
                //       duration: Duration(seconds: 2),
                //     ),
                //   );
                // } catch (e) {
                //   print('Error saving order to Firestore: $e');
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Error saving order to Firestore'),
                //       duration: Duration(seconds: 2),
                //     ),
                //   );
                // }
              },
            ),
          ),
        );
      },
    );
  }
}
