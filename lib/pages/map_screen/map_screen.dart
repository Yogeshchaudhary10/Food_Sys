import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
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
  MapController mapController = MapController();
  LatLng initialPosition = LatLng(27.700769, 85.300140);
  late List<Placemark> locationName;
  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    getLocation();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  getLocation() async {
    try {
      locationName = await placemarkFromCoordinates(
          initialPosition.latitude, initialPosition.longitude);

      print(locationName.first.toString());
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: initialPosition,
          zoom: 13,
          onTap: (tapPosition, point) {
            _handleTap(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: initialPosition,
                builder: (ctx) => SizedBox(
                  child: const Icon(
                    Icons.location_on,
                    size: 30.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      Positioned(
        left: 50,
        top: 200,
        child: Container(
          height: 40,
          width: 200,
          child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    locationName.first.locality.toString(),
                  ),
                  Text(
                    locationName.first.subLocality.toString(),
                  ),
                ]),
          ),
        ),
      )
    ]);

    //  Scaffold(
    //   // appBar: AppBar(
    //   //   backgroundColor: AppColors.orange,
    //   //   title: Text(
    //   //     "Address Page",
    //   //     style: TextStyle(color: AppColors.blackColor),
    //   //   ),
    //   //   centerTitle: true,
    //   //   leading: IconButton(
    //   //     onPressed: () {
    //   //       // Navigator.pushNamed(context, Routes.cartPage);
    //   //       Navigator.of(context)
    //   //           .push(MaterialPageRoute(builder: (context) => CombinedPage()));
    //   //     },
    //   //     icon: Icon(
    //   //       Icons.arrow_back_ios,
    //   //       color: AppColors.blackColor,
    //   //     ),
    //   //   ),
    //   // ),
    //   body: Center(
    //     child: Container(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           // InkWell(
    //           //     child: Text(location),
    //           //     onTap: () {
    //           //       _showModal(context);
    //           //     }),
    //           // InkWell(
    //           //     child: Text(location),
    //           //     onTap: () {
    //           //       _showModal(context);
    //           //     }),
    //           ElevatedButton(
    //             onPressed: () {
    //               _showModal(context, (value) {
    //                 latitude = value.latitude;
    //                 longitude = value.longitude;
    //                 print(latitude.toString() + "value" + longitude.toString());
    //               });
    //             },
    //             style: ButtonStyle(
    //               backgroundColor:
    //                   MaterialStateProperty.all<Color>(AppColors.blackColor),
    //             ),
    //             child: Text(location),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void _handleTap(LatLng location) {
    setState(() {
      initialPosition = location;
      print(initialPosition);
      getLocation();
    });
  }

  void _showModal(BuildContext context, Function(LatLong) value) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 800,
          color: AppColors.blackColor,
          child: Center(
            child: OpenStreetMapSearchAndPick(
              onGetCurrentLocationPressed: Future.value,
              center: LatLong(latitude, longitude),
              buttonColor: AppColors.blackColor,
              buttonText: ' Current Location',
              onPicked: (pickedData) {
                print(pickedData.address);
                // await value(pickedData.latLong);
                if (mounted) {
                  Navigator.pop(context);
                }
                // setState(() {
                location = pickedData.toString();
                latitude = pickedData.latLong.latitude;
                longitude = pickedData.latLong.longitude;
                // });

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
