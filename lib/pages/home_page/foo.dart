// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         '/page1': (BuildContext context) => Page1(),
//         '/page2': (BuildContext context) => Page2(),
//         '/page3': (BuildContext context) => Page3(),
//       },
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final List<String> itemList = [
//     'Page 1',
//     'Page 2',
//     'Page 3',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List View Navigation'),
//       ),
//       body: ListView.builder(
//         itemCount: itemList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(itemList[index]),
//             onTap: () {
//               // Navigate to the corresponding page
//               switch (index) {
//                 case 0:
//                   Navigator.pushNamed(context, '/page1');
//                   break;
//                 case 1:
//                   Navigator.pushNamed(context, '/page2');
//                   break;
//                 case 2:
//                   Navigator.pushNamed(context, '/page3');
//                   break;
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page 1'),
//       ),
//       body: Center(
//         child: Text('This is Page 1'),
//       ),
//     );
//   }
// }

// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page 2'),
//       ),
//       body: Center(
//         child: Text('This is Page 2'),
//       ),
//     );
//   }
// }

// class Page3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page 3'),
//       ),
//       body: Center(
//         child: Text('This is Page 3'),
//       ),
//     );
//   }
// }
