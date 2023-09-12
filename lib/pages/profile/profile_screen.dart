import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class ProfileScreen extends StatefulWidget {
  final String? uploadedImageUrl;

  const ProfileScreen({super.key, this.uploadedImageUrl});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection("users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            // Navigator.pushNamed(context, Routes.homeScreen);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.orange,
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, Routes.settingPage);
        //     },
        //     icon: Icon(
        //       Icons.settings,
        //       color: AppColors.blackColor,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              ClipOval(
                child: widget.uploadedImageUrl != null
                    ? Image.network(
                        widget.uploadedImageUrl!,
                        width: Dimension.width30 * 5,
                        height: Dimension.height30 * 5,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/Susisalad.png",
                        width: Dimension.width30 * 5,
                        height: Dimension.height30 * 5,
                        fit: BoxFit.cover,
                      ),
                // : SizedBox(height: Dimension.height20), you can use this insted of Image.asset
              ),
              SizedBox(height: Dimension.height20),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.editProfile);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Edit Profile"),
                ),
              ),
              SizedBox(height: Dimension.height30),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    final userData = FirebaseAuth.instance.currentUser;
                    final String? userName = userData?.displayName;

                    if (documents.isNotEmpty) {
                      Map<String, dynamic> data =
                          documents[0].data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          ReusableRow(
                            title: 'Username',
                            value: userName ?? '',
                            iconData: Icons.person,
                          ),
                          ReusableRow(
                            title: 'Email',
                            value: userData?.email.toString() ?? '',
                            iconData: Icons.email,
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No data available",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong",
                          style: Theme.of(context).textTheme.titleMedium),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const Divider(),
              SizedBox(height: Dimension.height10),
              ProfileMenuWidget(
                title: "Sign Out",
                icon: Icons.logout,
                endIcon: false,
                textColor: Colors.red,
                onPress: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Sign Out"),
                            ),
                          ],
                        ),
                        content: const Text("Do you want to sign out?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, Routes.loginScreen);
                              await _auth.signOut();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: Dimension.width10 * 4,
        height: Dimension.height10 * 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.radius20 * 5),
          color: AppColors.backgroundColor,
        ),
        child: Icon(
          icon,
          color: AppColors.greyShade200,
        ),
      ),
      title: Text(title),
      trailing: endIcon
          ? SizedBox(
              width: Dimension.width30,
              height: Dimension.height30,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.blackColor,
              ),
            )
          : null,
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;

  const ReusableRow({
    Key? key,
    required this.title,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Text(value),
          leading: Icon(iconData),
        ),
      ],
    );
  }
}
