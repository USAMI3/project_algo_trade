import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
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
