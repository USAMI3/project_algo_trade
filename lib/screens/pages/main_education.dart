import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/screens/home_screen.dart';
import 'package:project_algo_trade/screens/pages/advanced_education.dart';
import 'package:project_algo_trade/screens/pages/beginner_education.dart';
import 'package:project_algo_trade/screens/pages/intermediate_education.dart';

class MainEducationScreen extends StatefulWidget {
  const MainEducationScreen({Key? key}) : super(key: key);

  @override
  State<MainEducationScreen> createState() => _MainEducationScreenState();
}

class _MainEducationScreenState extends State<MainEducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Commons.mylightColor,
          elevation: 0,
          title: Text(
            "Educational Resources",
            style: TextStyle(
              color: Commons.myWhiteColor,
              fontSize: 20,
              fontFamily: 'ColfaxBold',
            ),
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BuildCard(
            text1: "Beginner",
            text2: "Free",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const BeginnerEducationScreen())));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BuildCard(
            text1: "Intermediate",
            text2: "Free",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const IntermediateEducationScreen())));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BuildCard(
            text1: "Advanced",
            text2: "Paid",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AdvancedEducationScreen())));
            },
          )
        ],
      ),
    );
  }
}
