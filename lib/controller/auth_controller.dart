import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pr_8_chat_app/view/screen/home/insta_homepage.dart';
import '../firebase_services/auth_services.dart';
import '../firebase_services/google_services.dart';
import '../view/screen/home/home.dart';
import '../view/screen/signup/signup_screen.dart';


class AuthController extends GetxController {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController txtfullname = TextEditingController();
  TextEditingController txtusername = TextEditingController();
  TextEditingController txtphone = TextEditingController();
  TextEditingController txtmessage = TextEditingController();
  TextEditingController txtedit = TextEditingController();

  RxString email = ''.obs;
  RxString name = ''.obs;
  RxString url = ''.obs;
  RxString receiveremail = ''.obs;
  RxString receivername = ''.obs;
  @override
  void onInit() {

    super.onInit();
    UserDetails();
  }
  void getreceiver(String email,String name) {
    receiveremail.value = email;
    receivername.value = name;
  }

  void UserDetails() {
    User? user = GoogleSignInServices.googleSignInServices.currentUser();
    if (user != null) {
      email.value = user.email!;
      url.value = user.photoURL!;
      name.value = user.displayName!;
    }
  }

  Future<void> signUp(String email, String password) async {
    if (!validateEmail(email) || !validatePassword(password)) {
      return;
    }

    try {
      bool emailExists = await AuthServices.authServices.checkEmail(email);
      if (emailExists) {
        Get.snackbar(
          'Sign Up Failed',
          'Email already in use. Please use a different email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        await AuthServices.authServices.createAccount(email, password);
        Get.snackbar(
          'Sign Up',
          'Sign Up Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(InstagramHomepage());
      }
    } catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    if (!validateEmail(email) || !validatePassword(password)) {
      return;
    }

    try {
      User? user = await AuthServices.authServices.signin(email, password);
      if (user != null) {
        Get.to(InstagramHomepage());
      } else {
        Get.snackbar(
          'Login Failed',
          'Incorrect email or password.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void emaillogout() async {
    await AuthServices.authServices.signout();
     GoogleSignInServices.googleSignInServices.emailLogout();
    Fluttertoast.showToast(
      msg: "Logged out successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Get.off(() => SignupScreen());
  }


  bool validateEmail(String email) {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        'Password cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }
}
