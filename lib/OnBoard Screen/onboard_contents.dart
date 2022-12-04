
class OnboardScreenContent {
  final String image;
  final String title;
  final String description;

  const OnboardScreenContent({required this.image, required this.title, required this.description});

}
List<OnboardScreenContent> contents = [
  const OnboardScreenContent(
      title: 'Automatic Trading',
      image: 'assets/images/forex_logo.png',
      description: "Trade Forex and crypto markets with ease using our TradeBot "
  ),
  const OnboardScreenContent(
      title: 'Trade Notifier',
      image: 'assets/images/notification.png',
      description: "Receive alerts for your running trades and TradeBot generated signals"
  ),
  const OnboardScreenContent(
      title: 'Profitable Strategies',
      image: 'assets/images/coin.png',
      description: "Learn how to be profitable with our advanced Forex Education material"
  ),
];