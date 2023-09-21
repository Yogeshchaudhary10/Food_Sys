import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/utils/utility.dart';
import 'package:food_ordering_app/resources/app_strings_manager.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class SignFormClass extends StatefulWidget {
  const SignFormClass({Key? key}) : super(key: key);

  @override
  State<SignFormClass> createState() {
    return SignFormClassState();
  }
}

class SignFormClassState extends State<SignFormClass> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController postController = TextEditingController();

  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool Loading = false;
  final CollectionReference fireStore =
      FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    child: Icon(
                      Icons.person_rounded,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mode),
                    labelText: AppStrings.userName,
                    hintText: AppStrings.userHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.kNameNullError;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: AppStrings.email,
                    hintText: AppStrings.enterEmail,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.kEmailNullError;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    labelText: AppStrings.phoneText,
                    hintText: AppStrings.phoneHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: phoneNo,
                  maxLength: 10, // Set the maximum length of the input to 10
                  keyboardType:
                      TextInputType.phone, // Set the keyboard type to phone
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.kPhoneNumberNullError;
                    }
                    if (value.length < 10) {
                      return "Please enter a valid phone number.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pin_drop),
                    labelText: AppStrings.locationText,
                    hintText: AppStrings.locationHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: location,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.kAddressNullError;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: AppStrings.password,
                      hintText: AppStrings.enterPassword,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )),
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.kPassNullError;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: "Confirm Password",
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  controller: confirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: AppColors.blackColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        Loading = true;
                      });

                      _auth
                          .createUserWithEmailAndPassword(
                              email: email.text.toString(),
                              password: password.text.toString())
                          .then((value) async {
                        String userId = value.user!.uid;
// Set the display name for the newly created user
                        await value.user!
                            .updateProfile(displayName: username.text);
                        fireStore.doc(userId).set({
                          'name': username.text,
                          'email': email.text,
                          'phone': phoneNo.text,
                          'location': location.text,
                        }).then((value) {
                          Utils().toastMessage("Success");
                        }).catchError((error) {
                          Utils().toastMessage(error.toString());
                        });

                        setState(() {
                          Loading = false;
                        });

                        Navigator.pushReplacementNamed(
                            context, Routes.loginScreen);
                      }).catchError((error) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                          Loading = false;
                        });
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, Routes.loginScreen),
                    child: const SizedBox(
                      child: Text(" Already a member? Login ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
