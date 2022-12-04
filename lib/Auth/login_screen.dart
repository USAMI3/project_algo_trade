import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/AppConfiguration/app_routes.dart';
import 'package:project_algo_trade/Auth/auth_controller.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/screens/settings_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  final chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1A2744),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(() => SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: controller.isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Color.fromRGBO(35, 51, 87, 1),
                        ))
                      : Center(
                          child: Container(
                            child: buildListView(
                                Size(constraints.maxWidth,
                                    constraints.maxHeight),
                                context),
                          ),
                        ),
                ));
          },
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) {
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
          controller: controller.emailController,
          onSaved: (value) {
            controller.emailController.text = value!;
          },
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'enter your email',
            hintStyle: TextStyle(
              fontFamily: 'Colfax',
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(BuildContext context) {
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
          child: Obx(
            () => TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: controller.isObscure.value,
              controller: controller.passwordController,
              cursorColor: Colors.white,
              onSaved: (value) {
                controller.passwordController.text = value!;
              },
              style: const TextStyle(color: Colors.white, fontFamily: 'Colfax'),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      controller.isObscure.value = !controller.isObscure.value;
                      // if (controller.isObscure.value = true) {
                      //   controller.isObscure.value = false;
                      // } else if (controller.isObscure.value = false) {
                      //   controller.isObscure.value = true;
                      // }
                    },
                    icon: const Icon(Icons.visibility)),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: 'enter your password',
                hintStyle: const TextStyle(
                  fontFamily: 'Colfax',
                  color: Colors.grey,
                ),
              ),
            ),
          )),
    );
  }

  Widget buildListView(Size size, BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(50, 72, 122, 1),
                      Color.fromRGBO(42, 62, 106, 0)
                    ],
                  )),
                  child: Center(
                    child: Image.asset(
                      "assets/images/notification.png",
                      height: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              const Text(
                "Login✌️",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'ColfaxBold',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              const Text(
                "You can only login to the app with your credentials",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Colfax',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.07,
              ),
              const Text(
                "Email",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Colfax',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              buildTextField(context),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              const Text(
                "Password",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Colfax',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              buildPasswordField(context),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.075,
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
                    "Login",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      fontFamily: 'ColfaxBold',
                    ),
                  ),
                  onPressed: () async {
                    controller.signIn(controller.emailController.text,
                        controller.passwordController.text);
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Colfax',
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Get.toNamed(AppRoutes.registerScreenRoute);
                    }),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'ColfaxBold',
                        color: Color.fromRGBO(112, 181, 105, 1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Commons.mylightColor,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      context: context,
                      builder: (context) => _buildSheet3(context));
                },
                child: const Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'ColfaxBold',
                      color: Color.fromRGBO(112, 181, 105, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        )
      ],
    );
  }

  _buildSheet3(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reset Password",
              style: TextStyle(
                color: Commons.myWhiteColor,
                fontFamily: 'ColfaxBold',
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            BuildTextField(
              controller: chatController.editEmailController,
              text1: "email address",
              text2: "Email",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Commons.myGreenColor,
              ),
              child: TextButton(
                onPressed: () {
                  if (chatController.editEmailController.text.isNotEmpty) {
                    chatController.resetPassword();
                    chatController.editEmailController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: Commons.myWhiteColor,
                    fontSize: 16,
                    fontFamily: 'ColfaxBold',
                  ),
                ),
              ),
            ),
            // BuildTextField(
            //   controller: controller.editAddressController,
            //   text1: "address",
            //   text2: "Address",
            // ),
            // BuildTextField(
            //   controller: controller.editPhoneController,
            //   text1: "phone no.",
            //   text2: "Phone",
            // ),
            // BuildTextField(
            //   controller: controller.editCountryController,
            //   text1: "country",
            //   text2: "Country",
            // ),
          ],
        ),
      ),
    );
  }
}
