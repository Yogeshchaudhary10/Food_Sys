import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/home_page/home_page_navigation_bar.dart';
import 'package:food_ordering_app/pages/sign_in/sigin_with_phone/login_with_phone.dart';
import 'package:food_ordering_app/pages/utils/utility.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../resources/app_strings_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/size_config.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  State<SignInScreen> createState() => _LoginFormClassState();
}

class _LoginFormClassState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  String passBackData = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool Loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      Loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      // SessionController().userId = value.user?.uid.toString();

      Navigator.pushReplacementNamed(context, Routes.homeScreen);

      Utils().toastMessage(value.user!.email.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // backgroundColor: AppColors.kSecondaryColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  child: Icon(
                    Icons.person_rounded,
                    size: 200,
                  ),
                ),
              ),
            ),
            // email fillup
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
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.kNameNullError;
                  }
                  return null;
                },
              ),
            ),
            //password fillup
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key),
                    labelText: AppStrings.password,
                    hintText: AppStrings.enterPassword,
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
                    )),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.kPassNullError;
                  }
                  return null;
                },
              ),
            ),
            //signIn button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: AppColors.kButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Loading = Loading;
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world, you'd oftern call as server aor save the infomration in a database.
                    // Navigator.pushReplacementNamed(context, Routes.homeScreen);
                    login();
                    setState(() {
                      Loading = true;
                    });
                  }
                },
                child: const Text(
                  AppStrings.signIn,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // forgort password
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.forgotPassword);
                  },
                  child: const SizedBox(
                    child: Text(AppStrings.forgotPassword,
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ),
            // donot have account
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.signupScreen);
                  },
                  child: const SizedBox(
                    child: Text(AppStrings.noAccount,
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimension.height20,
            ),
            //mobile sigin
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: AppColors.kButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneNumber()));
                },
                child: const Text(
                  "Signin with phone",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimension.height10 / 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: AppColors.kButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  signInWithGoogle().then((userCredential) {
                    if (userCredential != null) {
                      // Successful sign-in
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    } else {
                      // Sign-in failed
                      print('Google sign-in failed.');
                    }
                  });
                },
                child: const Text(
                  "Signin with Google",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // icon row
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SocialCard(
            //       icon: ImageAssets.googleIcon,
            //       press: () {},
            //     ),
            //     SocialCard(
            //       icon: ImageAssets.faceBookIcon,
            //       press: () {},
            //     ),
            //     SocialCard(
            //       icon: ImageAssets.twitterIcon,
            //       press: () {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // signInWithGoogle() async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //   AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);

  //   if (userCredential.user != null) {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => HomePage()));
  //   }
  // }
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Return the user credential
        return userCredential;
      } catch (e) {
        // Handle any errors that occurred during sign-in
        print(e.toString());
        return null;
      }
    }

    return null;
  }
}
