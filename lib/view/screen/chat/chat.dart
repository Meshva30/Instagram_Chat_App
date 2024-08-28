import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../firebase_services/chat_services.dart';
import '../../../firebase_services/google_services.dart';
import '../../../model/chat_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ChatServices.chatServices.getchat(
                    GoogleSignInServices.googleSignInServices
                        .currentUser()!
                        .email!,
                    controller.receiveremail.value),
                builder: (context, snapshot) {
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
                            (index) => Align(
                          alignment: (chatlist[index].sender ==
                              GoogleSignInServices.googleSignInServices
                                  .currentUser()!
                                  .email
                              ? Alignment.centerRight
                              : Alignment.centerLeft),
                          child: Container(
                            child: GestureDetector(
                              onLongPress: () {
                                if (chatlist[index].sender ==
                                    GoogleSignInServices.googleSignInServices
                                        .currentUser()!
                                        .email) {
                                  showMenu(
                                    context: context,
                                    position: const RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust position as needed
                                    items: [
                                      
                                      PopupMenuItem(
                                        child: const Text('Edit'),
                                        onTap: () {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            
                                            controller.txtedit = TextEditingController(text: chatlist[index].message);
                    
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Edit Message'),
                                                  content: TextField(
                                                    controller: controller.txtedit,
                                                    decoration: const InputDecoration(
                                                      hintText: 'Enter your edited message',
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                       
                                                        ChatServices.chatServices.updateChat(
                                                          chatid: chatid[index],
                                                          sender: controller.email.value,
                                                          receiver: controller.receiveremail.value,
                                                          message: controller.txtedit.text,
                                                        );
                                                        Get.back(); 
                                                      },
                                                      child: const Text('Save'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Get.back(); 
                                                      },
                                                      child: const Text('Cancel'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });
                                        },
                                      ),
                    
                                      PopupMenuItem(
                                        child: const Text('Delete'),
                                        onTap: () {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            ChatServices.chatServices.deleteChat(
                                              chatid: chatid[index],
                                              sender: controller.email.value,
                                              receiver: controller.receiveremail.value,
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                }
                              },
                              child: Card(
                                color: const Color(0xff951AC2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    chatlist[index].message!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.txtmessage,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Map<String, dynamic> chatdata = {
                        'sender': GoogleSignInServices.googleSignInServices
                            .currentUser()!
                            .email,
                        'receiver': controller.receiveremail.value,
                        'message': controller.txtmessage.text,
                        'timestamp': DateTime.now(),
                      };

                      ChatServices.chatServices.insertchat(
                          chatdata,
                          GoogleSignInServices.googleSignInServices
                              .currentUser()!
                              .email!,
                          controller.receiveremail.value);
                      controller.txtmessage.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
