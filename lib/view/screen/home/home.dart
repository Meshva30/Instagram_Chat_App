import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pr_8_chat_app/view/screen/signup/signup_screen.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../firebase_services/google_services.dart';
import '../../../firebase_services/user_services.dart';
import '../../../utils/userlist.dart';
import '../chat/chat.dart';
import 'componens/user.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    final ThemeController themeController = Get.put(ThemeController());
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: UserServices.userServices.getcurrentuser(
            GoogleSignInServices.googleSignInServices.currentUser()!,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }

            Map<String, dynamic> currentuser =
                snapshot.data?.data() as Map<String, dynamic>;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(currentuser['photourl']),
                  ),
                ),
                Text(currentuser['name']),
                Text(currentuser['email'] ?? "No email"),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'meshva_patel30',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
                onTap: () {
                  controller.emaillogout();
                  Fluttertoast.showToast(
                    msg: "Logged out successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Get.off(
                    () => SignupScreen(),
                  );
                },
                child: Icon(Icons.logout)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                color: themeController.isDarkMode.value
                    ? Color(0xff333333)
                    : Color(0xffE9E8E8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/img/ai.png'),
                   Text(
                    'Ask Meta AI or Search',
                    style: TextStyle(color: themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserStory(users: users[index]);
                },
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Requests',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream:
                    UserServices.userServices.getUser(controller.email.value),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    List userlist =
                        snapshot.data!.docs.map((e) => e.data()).toList();

                    return ListView.builder(
                      itemCount: userlist.length,
                      itemBuilder: (context, index) {
                        var user = userlist[index];

                        return GestureDetector(
                          onTap: () {
                            controller.getreceiver(userlist[index]['email'],
                                (userlist[index]['name']));
                            Get.to(ChatScreen());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user['photourl']),
                            ),
                            title: Text(user['name'] ?? 'No Name'),
                            subtitle: Text(
                                //'${user['email'] ?? 'No timestamp'} }',
                                'Sent 2h age'),
                            trailing: Icon(Icons.camera_alt_outlined),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No users found.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
