import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/models/chat_model.dart';
import 'package:project_algo_trade/models/firebase_model.dart';

class ChatController extends GetxController {
  final db = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();
  final editNameController = TextEditingController();
  final editPasswordController = TextEditingController();
  final editAddressController = TextEditingController();
  final editEmailController = TextEditingController();
  var users = FirebaseFirestore.instance.collection("users");
  bool dismounted = false;
  Timer? timer;
  Timer? btcTimer;
  Timer? ethTimer;
  Timer? adaTimer;
  Timer? bnbTimer;
  bool isBTC = false;
  String name = "";
  String apiKey = "";
  String secretKey = "";

  final userModel = FirebaseModel();
  final userModel1 = FirebaseModel();

  Stream<List<ChatModel>> readAlerts() {
    Stream<QuerySnapshot> stream = db
        .collection('chats')
        .orderBy("sending_time", descending: true)
        // .where("uid", isEqualTo: user!.uid)
        .snapshots();
    return stream.map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => ChatModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }

  Stream<List<ChatModel>> readAlerts1() {
    final stream = db
        .collection('chats')
        // .where("uid", isEqualTo: user!.uid)
        .snapshots();
    return stream.map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => ChatModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: editEmailController.text)
          .then((value) => Commons.showSnackBar(
              "Notification", "Password reset email sent successfully"));
    } on FirebaseAuthException catch (e) {
      Commons.showSnackBar("Notification", "Failed to send request");
    }
  }

  Future<void> getName() async {
    User? user = FirebaseAuth.instance.currentUser;
    users.doc(user!.uid).get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;
      userModel.name = data["name"];
      userModel.secretKey = data["secretKey"];
      userModel.apiKey = data["apiKey"];
      userModel1.name = data["name"];
      name = data["name"];
      // print(userModel.name);
    });
  }

  Future<void> deleteAll() async {
    User? user = FirebaseAuth.instance.currentUser;
    final collection = await FirebaseFirestore.instance
        .collection("chats")
        .orderBy("sending_time", descending: true)
        .limit(20)
        .get();
    var currentbatch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      currentbatch.delete(doc.reference);
    }
    return currentbatch.commit().then((value) {
      print("deleted");
    });
  }

  Future<void> uploadMessages() async {
    User? user = FirebaseAuth.instance.currentUser;
    final messageData = <String, dynamic>{
      "message": messageTextController.text,
      "sending_time": DateTime.now(),
      "uid": user!.uid,
      "name": userModel.name,
    };
    await db
        .collection("chats")
        .add(messageData)
        .then((value) => messageTextController.clear());
    // await db
    //     .collection("chats")
    //     .doc(user.uid)
    //     .set(messageData)
    //     .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> updateProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final messageData = <String, dynamic>{
      "name": editNameController.text,
    };
    await db
        .collection("users")
        .doc(user!.uid)
        .set(
            messageData,
            SetOptions(
              merge: true,
            ))
        .then((value) => getName());
    print("done");
    // await db
    //     .collection("chats")
    //     .doc(user.uid)
    //     .set(messageData)
    //     .onError((e, _) => print("Error writing document: $e"));
  }
}
