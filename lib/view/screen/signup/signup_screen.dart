import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pr_8_chat_app/controller/auth_controller.dart';
import 'package:pr_8_chat_app/view/screen/home/home.dart';
import 'package:pr_8_chat_app/view/screen/signin/signin_screen.dart';

import '../../../firebase_services/google_services.dart';
import '../../../firebase_services/user_services.dart';
import '../../../model/firebase_model.dart';
import '../home/insta_homepage.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController()); // Use Get.put to ensure controller is properly instantiated.

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                    height: 100,
                    child: Image.asset('assets/img/instagram.png')),
              ),
              Text(
                textAlign: TextAlign.center,
                'Sign up to post your\n adventures and also see what\nyour friends are up to! ',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  String status = await GoogleSignInServices
                      .googleSignInServices.signWithGoogle();
                  User? user = GoogleSignInServices.googleSignInServices
                      .currentUser();
                  Map m1 = {
                    'name': user!.displayName,
                    'email': user.email,
                    'photourl': user.photoURL
                  };
                  UserModel userModel = UserModel.fromMap(m1);
                  await UserServices.userServices.addUser(userModel);
                  Fluttertoast.showToast(msg: status);
                  if (status == 'Success') {
                    Get.to(InstagramHomepage());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 40, child: Image.asset('assets/img/google.png')),
                    Text('Log in with Google',
                        style: TextStyle(
                            color: Color(0xff3897F0),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
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
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: controller.txtfullname,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Full Name',
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
                      hintText: 'Mobile Number or Email',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: controller.txtusername,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Username',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: controller.txtpassword,
                    obscureText: true, // Mask the password input
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    Map m1 = {
                      'name': controller.txtfullname.text,
                      'phone': controller.txtphone.text,
                      'email': controller.txtemail.text,
                      'photourl':
                      'https://i.pinimg.com/236x/db/b9/cb/dbb9cbe3b84da22c294f57cc7847977e.jpg',
                    };
                    UserModel usermodel = UserModel.fromMap(m1);
                    await UserServices.userServices.addUser(usermodel);

                    Get.to(InstagramHomepage());

                    controller.signUp(
                        controller.txtemail.text, controller.txtpassword.text);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff3897F0)),
                    child: const Center(
                      child: Text(
                        'Sign Up',
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
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(SigninScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                    ),
                    Text(
                      'Sign In.',
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
