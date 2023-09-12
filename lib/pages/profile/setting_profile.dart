import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: AppColors.orange,

        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.homeScreen);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: AppColors.blackColor,
            // fontSize: Dimension.font26,
            //  fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: Dimension.width10 * 1.6,
            top: Dimension.height10 * 2.5,
            right: Dimension.width10 * 1.6),
        child: ListView(
          children: [
            // Text(
            //   "Settings",
            //   style: TextStyle(
            //       fontSize: Dimension.font26, fontWeight: FontWeight.w500),
            // ),
            // SizedBox(
            //   height: Dimension.height20 * 2,
            // ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppColors.blackColor,
                ),
                SizedBox(
                  width: Dimension.width10,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                      fontSize: Dimension.font20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: Dimension.height15,
              thickness: 2,
            ),
            SizedBox(
              height: Dimension.height10,
            ),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Content settings"),
            buildAccountOptionRow(context, "Social"),
            buildAccountOptionRow(context, "Language"),
            buildAccountOptionRow(context, "Privacy and security"),
            SizedBox(
              height: Dimension.height20 * 2,
            ),
            Row(
              children: [
                const Icon(
                  Icons.volume_up_outlined,
                  color: AppColors.blackColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: Dimension.font20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: Dimension.height15,
              thickness: 2,
            ),
            SizedBox(
              height: Dimension.height10,
            ),
            buildNotificationOptionRow("New for you", true),
            buildNotificationOptionRow("Account activity", true),
            buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: Dimension.height10 * 5,
            ),
            Center(
              child: OutlinedButton(
                // padding: EdgeInsets.symmetric(horizontal: 40),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  // Navigator.pushNamed(context, Routes.loginScreen);
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title:  const Row(children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 6.0),
                          //   child: Image.network(
                          //     "",
                          //     height: 20,
                          //     width: 20,
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Sign out "),
                          )
                        ]),
                        content: const Text("Do you want to sign out?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await _auth.signOut();
                              },
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, Routes.loginScreen);

                                await _auth.signOut();
                              },
                              child: const Text("Ok"))
                        ],
                      );
                    },
                  );
                  await _auth.signOut();
                },
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: Dimension.font20,
                        letterSpacing: 2.2,
                        color: AppColors.blackColor)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: Dimension.font20,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content:  const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Dimension.font20,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
