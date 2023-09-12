import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/about/about_page.dart';
import 'package:food_ordering_app/pages/cart/cart_history.dart';
import 'package:food_ordering_app/pages/cart/cart_page.dart';
import 'package:food_ordering_app/pages/feed_back_page/feedback_page.dart';
import 'package:food_ordering_app/pages/forget_password_page/forgot_password_page.dart';
import 'package:food_ordering_app/pages/home_page/home_page_navigation_bar.dart';
import 'package:food_ordering_app/pages/notification/notification_list_screen.dart.dart';
import 'package:food_ordering_app/pages/notification/notificationpage.dart';
import 'package:food_ordering_app/pages/payment/payment.dart';
import 'package:food_ordering_app/pages/profile/edit_profile.dart';
import 'package:food_ordering_app/pages/profile/profile_screen.dart';
import 'package:food_ordering_app/pages/profile/setting_profile.dart';
import 'package:food_ordering_app/pages/profile/upload_profile_image.dart';
import 'package:food_ordering_app/pages/search/search.dart';
import 'package:food_ordering_app/pages/sign_in/signin_screen.dart';
import 'package:food_ordering_app/pages/sign_up/signup_screen.dart';
import 'package:food_ordering_app/pages/splash/splash_page.dart';

class Routes {
  static const String splashScreen = "/SplashScreen";
  static const String loginScreen = "/LoginPage";
  static const String signupScreen = "/SignupPage";
  static const String homeScreen = "/HomePage";
  static const String forgotPassword = "/ForgotPassword";
  static const String cartPage = "/CartPage";
  static const String cartHistory = "/CartHistory";
  static const String profileScreen = "/ProfileScreen";
  static const String uploadImage = "/UploadProfile";

  static const String editProfile = "/EditProfilePage";
  static const String settingPage = "/SettingsPage ";
  static const String notificationList = "/NotificationListScreen ";
  static const String notificationPage = "/ NotificationPage";
  static const String aboutPage = "/AboutPage";
  static const String searchPage = "/Search";
  static const String paymentPage = "/Payment";
  static const String feedbackPage = "/FeedbackPage";
}

class RouteGenerator {
  static Route<dynamic> getRoute(
    RouteSettings routeSettings,
  ) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignFormClass());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case Routes.searchPage:
        return MaterialPageRoute(builder: (_) => const Search());

      case Routes.cartPage:
        return MaterialPageRoute(builder: (_) => const CartPage());

      case Routes.cartHistory:
        return MaterialPageRoute(builder: (_) => const CartHistory());

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routes.editProfile:
        return MaterialPageRoute(
            builder: (_) => const EditProfilePage(
                  imageUrl: '',
                ));

      case Routes.uploadImage:
        return MaterialPageRoute(builder: (_) => const ImageUploadScreen());

      case Routes.settingPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case Routes.notificationList:
        return MaterialPageRoute(
            builder: (_) => const NotificationListScreen());

      case Routes.notificationPage:
        return MaterialPageRoute(builder: (_) => const NotificationPage());

      case Routes.aboutPage:
        return MaterialPageRoute(builder: (_) => const AboutPage());

      case Routes.paymentPage:
        return MaterialPageRoute(builder: (_) =>  const Payment());

      case Routes.feedbackPage:
        return MaterialPageRoute(builder: (_) => const FeedbackPage());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("no Route found"),
              ),
              body: const Center(child: Text("no route found")),
            ));
  }
}
