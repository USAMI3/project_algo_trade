import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/models/chat_model.dart';
import 'package:project_algo_trade/models/firebase_model.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = Get.put(ChatController());
  List<ChatModel> data = [];
  User? user = FirebaseAuth.instance.currentUser;
  final userModel = FirebaseModel();

  @override
  void initState() {
    super.initState();
  }

  Widget buildAlert(ChatModel chatModel) {
    // var dt =
    //     DateTime.fromMillisecondsSinceEpoch(chatModel.sendingTime!.toInt());
    // var d24 = DateFormat().add_jm().format(dt);
    final Timestamp timestamp = chatModel.sendingTime as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('K:mm a').format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17, top: 8, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user!.uid == chatModel.uid
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 275),
                        decoration: const BoxDecoration(
                            color: Commons.mylightColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "${chatModel.name}",
                                style: const TextStyle(
                                  color: Commons.myGreenColor,
                                  fontSize: 15,
                                  fontFamily: 'ColfaxBold',
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              AutoSizeText(
                                "${chatModel.message}",
                                maxLines: 7,
                                style: const TextStyle(
                                  color: Commons.myWhiteColor,
                                  fontSize: 15,
                                  fontFamily: 'Colfax',
                                ),
                              ),
                              // const SizedBox(
                              //   width: 20,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  dateString,
                                  style: const TextStyle(
                                    color: Commons.myGreyColor,
                                    fontSize: 12,
                                    fontFamily: 'Colfax',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Commons.mylightColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/man.png"),
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Commons.myGreenColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/man.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 160),
                      decoration: const BoxDecoration(
                          color: Commons.myGreenColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "${chatModel.name}",
                              style: const TextStyle(
                                color: Commons.mainThemeColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ColfaxBold',
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              "${chatModel.message}",
                              style: const TextStyle(
                                color: Commons.mylightColor,
                                fontSize: 15,
                                fontFamily: 'Colfax',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                dateString,
                                style: TextStyle(
                                  color: Commons.myWhiteColor,
                                  fontSize: 12,
                                  fontFamily: 'Colfax',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        appBar: AppBar(
          backgroundColor: Commons.mylightColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            "Chat Room",
            style: TextStyle(
              fontFamily: 'ColfaxBold',
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<List<ChatModel>>(
          stream: controller.readAlerts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: Commons.mainThemeColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "No chats found!",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'ColfaxBold',
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "You don't have any chats to show.",
                        style: TextStyle(
                            fontFamily: 'Colfax',
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              data = snapshot.data!;
            }
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    reverse: true,
                    key: UniqueKey(),
                    children: data.map(buildAlert).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(20, 28, 47, 1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              style:
                                  const TextStyle(color: Commons.mylightColor),
                              controller: controller.messageTextController,
                              cursorColor:
                                  const Color.fromRGBO(96, 118, 166, 1),
                              decoration: const InputDecoration(
                                  hintText: 'Write a message',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Colfax',
                                    color: Color.fromRGBO(96, 118, 166, 1),
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Commons.myGreenColor,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (controller
                                  .messageTextController.text.isNotEmpty) {
                                controller.uploadMessages();
                              }
                            },
                            child: const Center(
                              child: Icon(
                                Icons.send_rounded,
                                color: Commons.myWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ));
  }
}
// TextButton(
//             onPressed: () {
//               print("clicked");
//               controller.uploadMessages();
//             },
//             child: Text("Send"))