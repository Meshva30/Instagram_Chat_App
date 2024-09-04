import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pr_8_chat_app/controller/theme_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../firebase_services/chat_services.dart';
import '../../../firebase_services/google_services.dart';
import '../../../model/chat_model.dart';
import '../../../utils/userlist.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    final ThemeController themeController = Get.put(ThemeController());
    final Rx<Color> backgroundColor = Colors.white.obs;

    void openColorPicker() {
      final isDarkMode = themeController.isDarkMode.value;
      final List<Color> colors =
          isDarkMode ? darkThemeColors : lightThemeColors;
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Background Color',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: colors.map((color) {
                    return GestureDetector(
                      onTap: () => backgroundColor.value = color,
                      // Change the background color
                      child: CircleAvatar(backgroundColor: color),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/img/mesu2.jpeg'),
          ),
        ),
        title: Obx(() => Text(controller.receivername.value)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.call),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.videocam_outlined),
          ),
        ],
      ),
      body: Obx(() => Container(
            color: backgroundColor.value, // Observe background color changes
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: ChatServices.chatServices.getchat(
                      GoogleSignInServices.googleSignInServices
                          .currentUser()!
                          .email!,
                      controller.receiveremail.value,
                    ),
                    builder: (context, snapshot) {
                      // Your existing StreamBuilder logic
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var Querydata = snapshot.data!.docs;
                      List chatid = Querydata.map((e) => e.id).toList();
                      List chats = Querydata.map((e) => e.data()).toList();
                      List<Chat> chatlist = [];

                      for (var chat in chats) {
                        chatlist.add(Chat.fromMap(chat));
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            chatlist.length,
                            (index) {
                              var chat = chatlist[index];
                              var formattedTime = chat.timestamp != null
                                  ? DateFormat('hh:mm a')
                                      .format(chat.timestamp!.toDate())
                                  : '';

                              return Align(
                                alignment: (chat.sender ==
                                        GoogleSignInServices
                                            .googleSignInServices
                                            .currentUser()!
                                            .email
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft),
                                child: GestureDetector(
                                  onLongPress: () {
                                    if (chat.sender ==
                                        GoogleSignInServices
                                            .googleSignInServices
                                            .currentUser()!
                                            .email) {
                                      showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                            100, 100, 0, 0),
                                        items: [
                                          PopupMenuItem(
                                            child: Text('Edit'),
                                            onTap: () {
                                              controller.txtedit =
                                                  TextEditingController(
                                                      text: chat.message);

                                              Future.delayed(Duration.zero, () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Edit Message'),
                                                      content: TextField(
                                                        controller:
                                                            controller.txtedit,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Enter your edited message',
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            ChatServices
                                                                .chatServices
                                                                .updateChat(
                                                              chatid:
                                                                  chatid[index],
                                                              sender: controller
                                                                  .email.value,
                                                              receiver: controller
                                                                  .receiveremail
                                                                  .value,
                                                              message:
                                                                  controller
                                                                      .txtedit
                                                                      .text,
                                                            );
                                                            Get.back(); // Close the dialog
                                                          },
                                                          child: Text('Save'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back(); // Close the dialog without saving
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              });
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Text('Delete'),
                                            onTap: () {
                                              ChatServices.chatServices
                                                  .deleteChat(
                                                chatid: chatid[index],
                                                sender: controller.email.value,
                                                receiver: controller
                                                    .receiveremail.value,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment: chat.sender ==
                                            GoogleSignInServices
                                                .googleSignInServices
                                                .currentUser()!
                                                .email
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        color: chat.sender ==
                                                GoogleSignInServices
                                                    .googleSignInServices
                                                    .currentUser()!
                                                    .email
                                            ? Color(0xff3313D6)
                                            : Color(0xff262626),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: chat.isImage == true
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    chat.message!,
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Container(
                                                        color: Colors.grey,
                                                        child: Icon(
                                                            Icons.broken_image,
                                                            color:
                                                                Colors.white),
                                                      );
                                                    },
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Text(
                                                  chat.message!,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                          formattedTime,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: TextField(
                      controller: controller.txtmessage,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: IconButton(
                          onPressed: () {
                            openColorPicker();
                          },
                          icon: Icon(Icons.color_lens),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.pickImage();
                              },
                              icon: Icon(Icons.image),
                            ),
                            IconButton(
                              onPressed: () {
                                controller
                                    .sendMessage(controller.txtmessage.text);
                              },
                              icon: Icon(
                                Icons.send,
                              ),
                            ),
                          ],
                        ),
                        hintText: 'Type a Message',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: themeController.isDarkMode.value
                                  ? Colors.white
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
