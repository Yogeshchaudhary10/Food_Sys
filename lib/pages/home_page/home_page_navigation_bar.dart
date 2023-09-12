import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/cart/cart_page.dart';
import 'package:food_ordering_app/pages/feed_back_page/feedback_page.dart';
import 'package:food_ordering_app/pages/home_page/main_home_page.dart';
import 'package:food_ordering_app/pages/profile/profile_screen.dart';
import 'package:food_ordering_app/resources/color_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> Pages = [
    const MainFoodPage(),
    const CartPage(),
    // const AddToCartPage(
    //   cartItems: [],
    // ),
    // CartHistory(),
    const ProfileScreen(),
    const FeedbackPage(),
    // NotificationListScreen(),
    // Container(
    //   child: Center(
    //     child: Text("Next page5"),
    //   ),
    // ),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(
              Icons.home_max_outlined,
            ),
            // title: Text("home"),
          ),
          BottomNavigationBarItem(
            label: "archibe",
            icon: Icon(
              Icons.archive,
            ),
            // title: Text("history")
          ),
          // BottomNavigationBarItem(
          //   label: "cart",
          //   icon: Icon(
          //     Icons.shopping_cart,
          //   ),
          //   // title: Text("cart"),
          // ),
          BottomNavigationBarItem(
            label: "person",
            icon: Icon(
              Icons.person,
            ),
            // title: Text("profile"),
          ),
          BottomNavigationBarItem(
            label: "feedbacks",
            icon: Icon(
              Icons.feedback_outlined,
            ),
            // title: Text("notification"),
          ),
        ],
      ),
    );
  }
}
