import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';

import '../Auth/auth_controller.dart';

class BrokerageScreen extends StatefulWidget {
  const BrokerageScreen({super.key});

  @override
  State<BrokerageScreen> createState() => _BrokerageScreenState();
}

class _BrokerageScreenState extends State<BrokerageScreen> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1A2744),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Container(
                child: buildListView(
                    Size(constraints.maxWidth, constraints.maxHeight), context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildListView(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Brokerage",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ColfaxBold',
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Enter your Alpaca Brokerage Keys",
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'ColfaxBold',
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildTextFieldApiKey(context),
          SizedBox(
            height: 20,
          ),
          buildTextFieldSecretKey(context),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(112, 181, 105, 1),
            ),
            child: TextButton(
              child: const Text(
                "Register",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontFamily: 'ColfaxBold',
                ),
              ),
              onPressed: () async {
                if (controller.apiKeyController.text.isNotEmpty ||
                    controller.secretKeyController.text.isNotEmpty) {
                  controller.signUp(controller.emailController.text,
                      controller.passwordController.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldApiKey(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(47, 68, 116, 1),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller.apiKeyController,
          cursorColor: Colors.white,
          onSaved: (value) {
            controller.apiKeyController.text = value!;
          },
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'enter your Alpaca api key',
            hintStyle: TextStyle(
              fontFamily: 'Colfax',
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldSecretKey(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(47, 68, 116, 1),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller.secretKeyController,
          cursorColor: Colors.white,
          onSaved: (value) {
            controller.secretKeyController.text = value!;
          },
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'enter your Alpaca secret key',
            hintStyle: TextStyle(
              fontFamily: 'Colfax',
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
