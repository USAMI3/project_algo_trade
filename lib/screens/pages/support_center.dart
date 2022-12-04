import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        appBar: AppBar(
          backgroundColor: Commons.mylightColor,
          title: const Text(
            "Customer Support",
            style: TextStyle(
              color: Commons.myWhiteColor,
              fontFamily: 'ColfaxBold',
              fontSize: 20,
            ),
          ),
          elevation: 0,
        ),
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: _buildListView(
                Size(constraints.maxWidth, constraints.maxHeight), context),
          );
        })));
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
          controller: controller.supportEmailController,
          cursorColor: Colors.white,
          onSaved: (value) {
            controller.supportEmailController.text = value!;
          },
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

  Widget buildTextFieldName(BuildContext context) {
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
          controller: controller.supportNameController,
          cursorColor: Colors.white,
          onSaved: (value) {
            controller.supportNameController.text = value!;
          },
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'enter your name',
            hintStyle: TextStyle(
              fontFamily: 'Colfax',
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(Size size, BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We're here to solve all of your trading related problems. Leave us a message.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ColfaxBold',
                  color: Commons.myGreenColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text(
                "Full Name",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Colfax',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              buildTextFieldName(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text(
                "Email",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Colfax',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              buildTextField(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Colfax',
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              buildTextFieldMessage(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              buildButton(context),
            ],
          ),
        ),
      ],
    );
  }

  buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              controller.supportEmailController.clear();
              controller.supportMessageController.clear();
              controller.supportNameController.clear();
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.037,
                width: MediaQuery.of(context).size.width * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Commons.myWhiteColor,
                  ),
                )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Commons.myGreenColor,
            ),
            child: TextButton(
              onPressed: () {
                controller.uploadTickets();
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

  buildTextFieldMessage(BuildContext context) {
    return Container(
      height: 140,
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
          controller: controller.supportMessageController,
          keyboardType: TextInputType.multiline,
          maxLines: 1000,
          textAlign: TextAlign.justify,
          cursorColor: Commons.myWhiteColor,
          style: const TextStyle(
            color: Commons.myWhiteColor,
          ),
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'state your Query',
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
