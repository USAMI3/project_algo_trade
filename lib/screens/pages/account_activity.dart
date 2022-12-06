// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/services/api_services.dart';

import '../../controllers/dashboard_controller.dart';
import '../../models/account_activity_model.dart';
import '../Chat/chat_controller.dart';
import 'package:intl/intl.dart';

class AccountActivity extends StatefulWidget {
  const AccountActivity({Key? key}) : super(key: key);

  @override
  State<AccountActivity> createState() => _AccountActivityState();
}

class _AccountActivityState extends State<AccountActivity> {
  final apiRequests = ApiRequests();
  final controller = Get.put(ChatController());
  @override
  void initState() {
    controller.accountActivityTimer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      apiRequests.getAccountActivity(
          controller.userModel.apiKey!, controller.userModel.secretKey!);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.accountActivityTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        appBar: AppBar(
          backgroundColor: Commons.mylightColor,
          title: const Text(
            "Account Activity",
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

  Widget _buildListView(Size size, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<DashboardController>(builder: (ccontroller) {
              return FutureBuilder<List<AccountActivityModel>?>(
                future: apiRequests.getAccountActivity(
                    controller.userModel.apiKey!,
                    controller.userModel.secretKey!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    if (data.length > 20) {
                      data.length = 19;
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      key: UniqueKey(),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final DateFormat formatter = DateFormat('MMM dd, yyyy');
                        String formatted =
                            formatter.format(data[index].transactionTime!);

                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                color: Commons.mylightColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Symbol:",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ColfaxBold',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          " ${data[index].symbol!.name}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'ColfaxBold',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Quantity: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ColfaxBold',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "${data[index].qty}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'ColfaxBold',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Price: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ColfaxBold',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "\$ ${data[index].price}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'ColfaxBold',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Order Type: ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'ColfaxBold',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              data[index].side!.name,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: 'ColfaxBold',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              "Transaction Date: ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'ColfaxBold',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              formatted,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: 'ColfaxBold',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
