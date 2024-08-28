import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pr_8_chat_app/view/screen/signup/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () => Get.to(SignupScreen()),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 280),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Center(
                child: Image.asset(
                  'assets/img/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 230,
            ),
            Container(height: 50, child: Image.asset('assets/img/meta.png')),
          ],
        ),
      ),
    );
  }
}
