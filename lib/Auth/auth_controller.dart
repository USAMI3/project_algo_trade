// ignore_for_file: unused_catch_clause

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/AppConfiguration/app_routes.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';
import 'package:project_algo_trade/models/firebase_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/shared_pref_class.dart';

import '../models/broker_model.dart';
import '../services/api_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  BrokerAccountModel? brokerAccountModel;

  final apiKeyController = TextEditingController();
  final secretKeyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final apiRequests = ApiRequests();
  final auth = FirebaseAuth.instance;
  final dashboardController = Get.put(DashboardController());
  final chatController = Get.put(ChatController());
  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
                isLoading.value = false,
                clearFields(),
                Commons.showSnackBar("Notification", "Registered successfully"),
                Get.toNamed(AppRoutes.loginScreenRoute)
              });
    } on Exception catch (e) {
      isLoading.value = false;
      Commons.showSnackBar("Alert", "Email Already in use");
    }
  }

  Future<void> getAccountDataonSignUp(String apikey, String secretKey) async {
    // isLoading.value = false;
    await apiRequests.connectAlpacaOnSignUp(apikey, secretKey).then((value) {
      brokerAccountModel = value;
      if (value != null) {
        signUp(emailController.text, passwordController.text);
      }
    }).onError((error, stackTrace) {
      Commons.showSnackBar("Alert", "Invalid API Key");
    });
    // isLoading.value = false;
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                isLoading.value = false,
                sharedPrefs.isLoggedIn = true,
                clearFields(),
                dashboardController.setGreet(),
                // chatController.getName(),
                chatController.getName(),
                Get.toNamed(AppRoutes.dashBoardScreenRoute),
              });
    } on FirebaseAuthException catch (e) {
      Commons.showSnackBar("Notification", "Invalid Credentials");
      isLoading.value = false;
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    FirebaseModel userModel = FirebaseModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.password = passwordController.text;
    userModel.name = nameController.text;
    userModel.apiKey = apiKeyController.text;
    userModel.secretKey = secretKeyController.text;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
