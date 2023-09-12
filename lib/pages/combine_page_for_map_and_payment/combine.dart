import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/map_screen/map_screen.dart';
import 'package:food_ordering_app/pages/payment/payment.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';

class CombinedPage extends StatefulWidget {
  const CombinedPage({super.key, this.total = 0});
  final int total;

  @override
  _CombinedPageState createState() => _CombinedPageState();
}

class _CombinedPageState extends State<CombinedPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const Text(
          'Check Out Page',
          style: TextStyle(color: AppColors.blackColor),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, Routes.homeScreen);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.blackColor,
            ),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [const MapScreen(), Payment(total: widget.total)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Address',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
        ],
      ),
    );
  }
}

// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: Center(
//         child: Text(
//           'First Page',
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//       child: Center(
//         child: Text(
//           'Second Page',
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
