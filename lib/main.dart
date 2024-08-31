import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr_8_chat_app/firebase_services/google_services.dart';


import 'package:pr_8_chat_app/view/screen/home/insta_homepage.dart';
import 'package:pr_8_chat_app/view/screen/signin/signin_screen.dart';
import 'controller/theme_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() =>
       GetMaterialApp(
        debugShowCheckedModeBanner: false,
         theme: ThemeData.light(), // Light theme data
         darkTheme: ThemeData.dark(), // Dark theme data
         themeMode: themeController.theme,

        home: GoogleSignInServices.googleSignInServices.currentUser() == null
            ? const SigninScreen()
            : InstagramHomepage(),
      ),
    );
  }
}
