import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';

class BeginnerEducationScreen extends StatefulWidget {
  const BeginnerEducationScreen({Key? key}) : super(key: key);

  @override
  State<BeginnerEducationScreen> createState() =>
      _BeginnerEducationScreenState();
}

class _BeginnerEducationScreenState extends State<BeginnerEducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        appBar: AppBar(
          title: const Text(
            "Beginners Guide",
            style: TextStyle(
              color: Commons.myWhiteColor,
              fontSize: 22,
              fontFamily: 'ColfaxBold',
            ),
          ),
          backgroundColor: Commons.mylightColor,
        ),
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Expanded(
                child: _buildListView(
                    Size(constraints.maxWidth, constraints.maxHeight), context),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          );
        })));
  }

  final headingStyle = const TextStyle(
    color: Commons.myGreenColor,
    fontSize: 20,
    fontFamily: 'ColfaxBold',
  );
  final simpleStyle = const TextStyle(
    color: Commons.myWhiteColor,
    fontSize: 16,
    fontFamily: 'Colfax',
  );

  Widget _buildListView(Size size, BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "What is Online trading?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  "Generally, online trading refers to buying and selling Stocks, Forex (FX) and Cryptocurrencies via the Internet by a single click. With online trading, in most cases customers access a brokerage firm through their regular Internet Service Provider. Once there, customers may consult information provided on the application and log into their accounts to place orders and monitor account activity.",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "What is Forex (FX)?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  "The foreign exchange market, which is usually known as “forex” or “FX,” is the largest financial market in the world with volume of around \$6.6 Trillion. The FX market is a global, decentralized market where the world’s currencies change hands. Exchange rates change by the second, so the market is constantly in flux. ",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  "Currencies trade against each other as exchange rate pairs. For example, EUR/USD is a currency pair for trading the euro against the U.S. dollar.",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx1.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "What are the risks of Trading?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """There is risk of loss associated with investing in securities regardless of the method used. New investors need to understand the principles of investing, their own risk tolerance, and their investment goals before venturing into the market. Online investors should be skeptical of advices and tips provided in Chat room or Educational Material. Also, for some online investors, there is a temptation to "overtrade" by trading too frequently or impulsively without considering their investment goals or risk tolerance. Overtrading can affect investment performance, raise trading costs, and cause huge losses.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "Why do we need a Brokerage firm?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """All trades involve a brokerage firm. A broker is a place where buyers and sellers go to buy and sell currencies.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """The forex broker operates as a middleman between you and the market. In other words, in order to find a buyer or a seller of currencies, you can go to a broker, and they match you up with either a respective seller or a respective buyer. There are many brokerage firms for forex trading.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "What are Forex Charts?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """A forex chart is a price chart showing the historical price and volume data on one or more currency pairs. A forex chart, thus, graphically depicts the historical behavior of a currency across various time frames, along with technical patterns & indicators and overlays.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx2.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "Which charts are we using for Trading?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """We will use Trading View charts for Forex trading. Trading View is a charting platform used by 30M+ traders and investors worldwide to spot opportunities across global markets. """,
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx3.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
