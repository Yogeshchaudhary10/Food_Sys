import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/pages/profile/profile_screen.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class EditProfilePage extends StatefulWidget {
  final String imageUrl;

  const EditProfilePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController uname = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  bool showPassword = false;

  @override
  void dispose() {
    uname.dispose();
    passwordController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, Routes.profileScreen);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingPage);
            },
            icon: const Icon(
              Icons.settings,
              color: AppColors.blackColor,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: Dimension.width15,
          top: Dimension.height10 * 2.5,
          right: Dimension.width15,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(children: [
            SizedBox(
              height: Dimension.height15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: Dimension.width10 * 13,
                    height: Dimension.height10 * 13,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Container(
                        color: AppColors.blackColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: Dimension.height20 * 2,
                      width: Dimension.height20 * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: AppColors.blackColor,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.uploadImage);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Dimension.height10 * 3.5),
            buildTextField("Full Name", "Your Name", false, uname),
            SizedBox(height: Dimension.height10 * 3.5),
            buildTextField("Password", "********", true, passwordController),
            SizedBox(height: Dimension.height10 * 3.5),
            buildTextField(
              "Location",
              "Your Location",
              false,
              locationController,
            ),
            SizedBox(height: Dimension.height10 * 3.5),
            InkWell(
              onTap: () {
                Navigator.pop(context, Routes.profileScreen);
              },
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Set the background color to black
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Set the text color to white
                ),
                onPressed: saveChangesToFirestore,
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: Dimension.font16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  TextField buildTextField(
    String labelText,
    String placeholder,
    bool isPasswordTextField,
    TextEditingController controller,
  ) {
    return TextField(
      obscureText: isPasswordTextField ? !showPassword : false,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.blackColor,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.only(bottom: 3),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: Dimension.font16,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Future<void> saveChangesToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final fullName = uname.text;
      final location = locationController.text;
      log("userid ${user!.uid}");

      final userRef = _firestore.collection('users').doc(user.uid);

      await userRef.update({
        'fullName': fullName,
        'location': location,
      });

      // Update the user's display name here
      await user.updateProfile(displayName: fullName);
      await user.reload(); // Reload the user for the changes to take effect

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      uname.clear();
      locationController.clear();
    } catch (e) {
      print('Error saving changes to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving changes to Firestore'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
