import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

Future<void> main() async {
  // await dep.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_d5d9f63743584dc38753056b0cc737d5",
      enabledDebugging: true,
      builder: (context, navkey) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Ordering',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: navkey,
          localizationsDelegates: const [KhaltiLocalizations.delegate],
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashScreen,
          // home: MyApp()
        );
      },
    );
  }
}
