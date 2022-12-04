import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
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
    return Container();
  }
}
