import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pr_8_chat_app/controller/auth_controller.dart';
import 'package:pr_8_chat_app/firebase_services/google_services.dart';
import 'package:pr_8_chat_app/model/firebase_model.dart';
import 'package:pr_8_chat_app/view/screen/home/insta_homepage.dart';
import 'package:pr_8_chat_app/view/screen/signup/signup_screen.dart';

import '../../../firebase_services/user_services.dart';
import '../home/home.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller= AuthController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Center(
                child: Container(
                    height: 100,
                    child: Image.asset('assets/img/instagram.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: controller.txtemail,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Phone number,email or username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: controller.txtpassword,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Password',
                      suffixIcon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {

                    controller.signIn(
                        controller.txtemail.text, controller.txtpassword.text);
                    Get.to(InstagramHomepage());
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff3897F0)),
                    child: const Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot your login details?',
                  ),
                  Text(
                    'Get help logging in.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                    )),
                    SizedBox(
                      width: 7,
                    ),
                    Text('OR'),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                    ),),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  String status = await GoogleSignInServices.googleSignInServices.signWithGoogle();
                  User? user= GoogleSignInServices.googleSignInServices.currentUser();
                  Map m1 = {
                    'name':user!.displayName,
                    'email':user.email,
                    'photourl':user.photoURL
                  };
                  UserModel userModel = UserModel.fromMap(m1);
                  await UserServices.userServices.addUser(userModel);
                  Fluttertoast.showToast(msg: status);
                  if(status=='Success'){
                    Get.to(InstagramHomepage());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 30, child: Image.asset('assets/img/google.png')),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Log in with Google',
                        style: TextStyle(
                            color: Color(0xff3897F0),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(
                height: 110,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(SignupScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                    ),
                    Text(
                      'Sign up.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
