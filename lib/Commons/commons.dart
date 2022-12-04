import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Commons {
  static const mainThemeColor = Color(0xFF1A2744);
  static const myWhiteColor = Color.fromARGB(255, 255, 255, 255);
  static const myGreyColor = Color.fromARGB(255, 148, 145, 145);
  static const mylightColor = Color.fromRGBO(49, 67, 107, 1);
  static const myGreenColor = Color.fromRGBO(112, 181, 105, 1);

  static showSnackBar(String title, String message) {
    return Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      maxWidth: 500,
      backgroundColor: Colors.white,
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
    );
  }
}
