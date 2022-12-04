import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_algo_trade/Commons/commons.dart';

class AdvancedEducationScreen extends StatefulWidget {
  const AdvancedEducationScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedEducationScreen> createState() =>
      _AdvancedEducationScreenState();
}

class _AdvancedEducationScreenState extends State<AdvancedEducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        appBar: AppBar(
          title: const Text(
            "Advanced Guide",
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
                "What are indicators?",
                style: headingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """Trading indicators are mathematical computations plotted as lines on a price chart that aid traders in identifying certain signs and trends in the stock market. They are simply a set of tools applied to a trading chart to demystify the market and make a clearer analysis. Using trading indicators is part of any technical trader’s strategy. Paired with the right risk management tools, it could help you gain more insight into price trends.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "Trading indicators every trader should know",
                style: TextStyle(
                  color: Commons.myGreenColor,
                  fontSize: 17,
                  fontFamily: 'ColfaxBold',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AutoSizeText(
                "1.	Moving average (MA)",
                style: TextStyle(
                  color: Commons.myGreenColor,
                  fontSize: 15,
                  fontFamily: 'ColfaxBold',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """The MA – or ‘simple moving average’ (SMA) – is an indicator used to identify the direction of a current price trend, without the interference of shorter-term price spikes.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx7.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """The data used depends on the length of the MA. For example, a 200-day MA requires 200 days of data. By using the MA indicator, you can study levels of support and resistance and see previous price action (the history of the market). This means you can also determine possible future patterns.""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx8.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "2.	Moving average convergence divergence (MACD)",
                style: TextStyle(
                  color: Commons.myGreenColor,
                  fontSize: 15,
                  fontFamily: 'ColfaxBold',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """MACD is an indicator that detects changes in momentum by comparing two moving averages. It can help traders identify possible buy and sell opportunities around support and resistance levels.
‘Convergence’ means that two moving averages are coming together, while ‘divergence’ means that they’re moving away from each other. If moving averages are converging, it means momentum is decreasing, whereas if the moving averages are diverging, momentum is increasing.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx9.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "3.	Relative strength index (RSI)",
                style: TextStyle(
                  color: Commons.myGreenColor,
                  fontSize: 15,
                  fontFamily: 'ColfaxBold',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """RSI is mostly used to help traders identify momentum, market conditions and warning signals for dangerous price movements. RSI is expressed as a figure between 0 and 100. An asset around the 70 level is often considered overbought, while an asset at or near 30 is often considered oversold.
An overbought signal suggests that short-term gains may be reaching a point of maturity and assets may be in for a price correction. In contrast, an oversold signal could mean that short-term declines are reaching maturity and assets may be in for a rally.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx10.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AutoSizeText(
                "4.	Bollinger bands",
                style: TextStyle(
                  color: Commons.myGreenColor,
                  fontSize: 15,
                  fontFamily: 'ColfaxBold',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: AutoSizeText(
                  """A Bollinger band is an indicator that provides a range within which the price of an asset typically trades. The width of the band increases and decreases to reflect recent volatility. The closer the bands are to each other – or the ‘narrower’ they are – the lower the perceived volatility of the financial instrument. The wider the bands, the higher the perceived volatility.
Bollinger bands are useful for recognizing when an asset is trading outside of its usual levels and are used mostly as a method to predict long-term price movements. When a price continually moves outside the upper parameters of the band, it could be overbought, and when it moves below the lower band, it could be oversold.
""",
                  style: simpleStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("assets/images/fx11.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
