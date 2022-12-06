import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Auth/login_screen.dart';
import 'package:project_algo_trade/models/broker_model.dart';
import 'package:project_algo_trade/screens/Chat/chat_controller.dart';
import 'package:project_algo_trade/screens/pages/account_activity.dart';
import 'package:project_algo_trade/screens/pages/main_education.dart';
import 'package:project_algo_trade/screens/pages/support_center.dart';
import 'package:project_algo_trade/services/api_services.dart';
import 'package:project_algo_trade/shared_pref_class.dart';

import '../Commons/commons.dart';
import '../controllers/dashboard_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final controller = Get.put(ChatController());
  final dashboardController = Get.put(DashboardController());

  final apiRequests = ApiRequests();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              child: _buildListView(
                  Size(constraints.maxWidth, constraints.maxHeight), context),
            ),
          );
        })));
  }

  Widget _buildListView(Size size, BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Commons.mylightColor,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16))),
                            context: context,
                            builder: (context) => _buildSheet2(context));
                      },
                      child: ClipOval(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipOval(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Commons.mylightColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Image.asset("assets/images/man.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.userModel.name}",
                            style: const TextStyle(
                              color: Commons.myWhiteColor,
                              fontFamily: 'ColfaxBold',
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Commons.mylightColor,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16))),
                                  context: context,
                                  builder: (context) => _buildSheet(context));
                            },
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Commons.myGreyColor,
                                fontFamily: 'Colfax',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Row(
                    children: [
                      FutureBuilder<BrokerAccountModel?>(
                        future: apiRequests.connectAlpaca(
                            controller.userModel.apiKey!,
                            controller.userModel.secretKey!),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.hasData) {
                            final data = snapshot.data;
                            final cash = double.tryParse(data!.cash!);
                            return BuildContainer(
                              iconData: Icons.monetization_on_rounded,
                              text1: "${cash!.toInt()}",
                              text2: "Total balance",
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      const BuildContainer(
                        iconData: Icons.redo_outlined,
                        text1: "1",
                        text2: "Brokerages",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: [
                      RowWidget(
                        icon: Icons.payments_outlined,
                        text: "Account Activity",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => const AccountActivity())));
                        },
                      ),
                      RowWidget(
                        icon: Icons.question_mark,
                        text: "Support center",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => const SupportScreen())));
                        },
                      ),
                      RowWidget(
                        icon: Icons.wysiwyg_sharp,
                        text: "Educational material",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const MainEducationScreen())));
                        },
                      ),
                      RowWidget(
                        icon: Icons.logout,
                        text: "Logout",
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          sharedPrefs.isLoggedIn = false;
                          Get.delete<DashboardController>();
                          Get.off(() => const LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  _buildSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit your profile",
              style: TextStyle(
                color: Commons.myWhiteColor,
                fontFamily: 'ColfaxBold',
                fontSize: 18,
              ),
            ),
            BuildTextField(
              controller: controller.editNameController,
              text1: "name",
              text2: "Name",
            ),

            const Text(
              "Reset Password?",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Colfax',
                  color: Colors.white),
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
                  showModalBottomSheet(
                      backgroundColor: Commons.mylightColor,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      context: context,
                      builder: (context) => _buildSheet3(context));
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
            buildButton(context),
          ],
        ),
      ),
    );
  }

  _buildSheet3(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            BuildTextField(
              controller: controller.editEmailController,
              text1: "email address",
              text2: "Email",
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
                  if (controller.editEmailController.text.isNotEmpty) {
                    controller.resetPassword();
                    controller.editEmailController.clear();
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

  _buildSheet2(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Your profile details",
              style: TextStyle(
                color: Commons.myWhiteColor,
                fontFamily: 'ColfaxBold',
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(
                    color: Commons.myWhiteColor,
                    fontFamily: 'ColfaxBold',
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Text(
                  "${controller.userModel.name}",
                  style: const TextStyle(
                    color: Commons.myGreenColor,
                    fontFamily: 'Colfax',
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            // const Text(
            //   "Address:",
            //   style: TextStyle(
            //     color: Commons.myWhiteColor,
            //     fontFamily: 'ColfaxBold',
            //     fontSize: 18,
            //   ),
            // ),
            // const Text(
            //   "Phone:",
            //   style: TextStyle(
            //     color: Commons.myWhiteColor,
            //     fontFamily: 'ColfaxBold',
            //     fontSize: 18,
            //   ),
            // ),
            // const Text(
            //   "Country:",
            //   style: TextStyle(
            //     color: Commons.myWhiteColor,
            //     fontFamily: 'ColfaxBold',
            //     fontSize: 18,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Commons.myGreenColor,
            ),
            child: TextButton(
              onPressed: () {
                if (controller.editNameController.text.isNotEmpty) {
                  controller.updateProfileData().then((value) {
                    setState(() {
                      controller.userModel.name =
                          controller.editNameController.text;
                    });
                    controller.editNameController.clear();
                    controller.editPasswordController.clear();
                    Navigator.pop(context);
                    Commons.showSnackBar(
                        "Notification", "Changes saved successfully");
                  });
                } else {
                  Commons.showSnackBar("Alert", "Please fill in the fields");
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Commons.myWhiteColor,
                  fontSize: 16,
                  fontFamily: 'ColfaxBold',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text1;
  final String text2;
  const BuildTextField({
    Key? key,
    required this.controller,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text2,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              fontFamily: 'Colfax',
              color: Colors.white),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
              color: Commons.myGreyColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TextFormField(
              controller: controller,
              cursorColor: Colors.white,
              autofocus: false,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: 'enter your $text1',
                hintStyle: const TextStyle(
                  fontFamily: 'Colfax',
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RowWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  const RowWidget(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: Commons.myWhiteColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Colfax',
                fontSize: 17,
                color: Commons.myWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildContainer extends StatelessWidget {
  final IconData iconData;
  final String text1;
  final String text2;

  const BuildContainer(
      {Key? key,
      required this.iconData,
      required this.text1,
      required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: Commons.myWhiteColor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              text1,
              style: const TextStyle(
                  color: Commons.myWhiteColor,
                  fontSize: 18,
                  fontFamily: 'ColfaxBold'),
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Colfax',
                color: Commons.myWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
