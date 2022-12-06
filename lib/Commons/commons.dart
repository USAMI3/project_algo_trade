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
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 40,
          width: 40,
          child: Image.asset("assets/images/001-bot.png"),
        ),
      ),
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'ColfaxBold',
        ),
      ),
      maxWidth: 500,
      backgroundColor: Commons.myGreenColor,
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'ColfaxBold',
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
    );
  }
}
