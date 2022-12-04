import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';

class IntermediateEducationScreen extends StatefulWidget {
  const IntermediateEducationScreen({Key? key}) : super(key: key);

  @override
  State<IntermediateEducationScreen> createState() =>
      _IntermediateEducationScreenState();
}

class _IntermediateEducationScreenState
    extends State<IntermediateEducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        appBar: AppBar(
          title: const Text(
            "Intermediate Guide",
            style: TextStyle(
              color: Commons.myWhiteColor,
              fontSize: 22,
              fontFamily: 'ColfaxBold',
            ),
          ),
          elevation: 0,
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
                "What is Price Action?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: AutoSizeText(
                  "Price action in trading analyses the performance of a security, index, commodity or currency to predict what it might do in the future. If your price action analysis tells you that the price is about to rise, you might want to take a long position, or if you believe that the price will fall, you might choose to short the asset.",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx5.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: AutoSizeText(
                  "It helps traders and investors navigate the gap between intrinsic value and market price by leveraging techniques like statistical analysis and behavioral economics. Technical analysis helps guide traders to what is most likely to happen given past information. Most Traders use both technical and fundamental analysis to make final decisions.",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx6.jpg"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "What is Fundamental Analysis?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """Fundamental analysis (FA) measures  currencies intrinsic value by examining related economic and financial factors. Fundamental analysis is a method of determining a currency's real or "fair market" value.""",
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
                  "Fundamental analysis includes news factors as well that can affect the currency’s value, from macroeconomic factors such as the state of the economy and industry conditions to microeconomic factors like the effectiveness of the country's management.",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: const AutoSizeText(
                  "Check out News section for daily news updates from around the Globe.",
                  style: TextStyle(
                    color: Commons.myGreenColor,
                    fontSize: 15,
                    fontFamily: 'ColfaxBold',
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "What is Pip?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """You’ve probably heard of the terms “pips,” “points“, “pipettes,” and “lots” thrown around, and now we’re going to explain what they are and show you how their values are calculated. Don’t even think about trading until you are comfortable with pip values and calculating profit and loss.""",
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
                  """The unit of measurement to express the change in value between two currencies is called a “pip.” If EUR/USD moves from 1.1050 to 1.1051, that .0001 USD rise in value is ONE PIP.""",
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
                  """Most pairs go out to 4 decimal places, but there are some exceptions like Japanese yen pairs (they go out to two decimal places). For example, for EUR/USD, it is 0.0001, and for USD/JPY, it is 0.01.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx4.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "How to Calculate the Value of a Pip?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """As each currency has its own relative value, it’s necessary to calculate the value of a pip for that particular currency pair.""",
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
                  """In the following example, we will use a quote with 4 decimal places. For the purpose of better explaining the calculations, exchange rates will be expressed as a ratio (i.e., EUR/USD at 1.2500 will be written as “1 EUR / 1.2500 USD”)""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: const AutoSizeText(
                  """Example: USD/CAD = 1.0200""",
                  style: TextStyle(
                    color: Commons.myGreenColor,
                    fontSize: 15,
                    fontFamily: 'ColfaxBold',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """To be read as 1 USD to 1.0200 CAD (or 1 USD/1.0200 CAD). (The value change in counter currency) times the exchange rate ratio = pip value (in terms of the base currency)""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """[.0001 CAD] x [1 USD/1.0200 CAD]""",
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
                  """[(.0001 CAD) / (1.0200 CAD)] x 1 USD = 0.00009804 USD per unit traded""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """Using this example, if we traded 10,000 units of USD/CAD, then a one pip change to the exchange rate would be approximately a 0.98 USD change in the position value (10,000 units x 0.00009804 USD/unit).""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
                "What is a Lot in Forex?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """Forex is commonly traded in specific amounts called lots, or basically the number of currency units you will buy or sell.
A “lot” is a unit measuring a transaction amount. When you place orders on your trading platform, orders are placed in sizes quoted in lots.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """The standard size for a lot is 100,000 units of currency, and now, there are also mini, micro, and nano lot sizes that are 10,000, 1,000, and 100 units.
As you may already know, the change in a currency value relative to another is measured in “pips,” which is a very, very small percentage of a unit of currency’s value.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """As you may already know, the change in a currency value relative to another is measured in “pips,” which is a very, very small percentage of a unit of currency’s value.
To take advantage of this minute change in value, you need to trade large amounts of a particular currency in order to see any significant profit or loss. But we use leverage to increase our position size.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   child: Image.asset("assets/images/fx2.png"),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "What is Leverage?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """You are probably wondering how a small investor like yourself can trade such large amounts of money.
Leverage in forex is a technique that enables traders to 'borrow' capital in order to gain a larger exposure to the forex market, with a comparatively small deposit. It offers the potential for traders to magnify potential profits, as well as losses if trade without risk management which we studied in Beginners Guide.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   child: Image.asset("assets/images/fx3.png"),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
