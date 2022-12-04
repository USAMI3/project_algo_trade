import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_algo_trade/Commons/commons.dart';
import 'package:project_algo_trade/controllers/dashboard_controller.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Commons.mainThemeColor,
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recent news",
                  style: TextStyle(
                      color: Commons.myWhiteColor,
                      fontFamily: 'ColfaxBold',
                      fontSize: 20),
                ),
              ),
              Expanded(
                child: _buildListView(
                    Size(constraints.maxWidth, constraints.maxHeight), context),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          );
        })));
  }

  getLength() {
    if (controller.newsData != null) {
      return controller.newsData!.data!.length;
    }
    return 1;
  }

  Widget _buildListView(Size size, BuildContext context) {
    return ListView.builder(
        itemCount: getLength(),
        itemBuilder: ((context, index) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              controller.newsData != null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                        color: Commons.mylightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Commons.mainThemeColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                  "${controller.newsData!.data![index].imageUrl}"),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                "${controller.newsData!.data![index].title}",
                                style: TextStyle(
                                  color: Commons.myWhiteColor,
                                  fontFamily: 'Colfax',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: Text(
                                "${controller.newsData!.data![index].sentiment}",
                                style: TextStyle(
                                  color: Commons.myGreenColor,
                                  fontFamily: 'ColfaxBold',
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.navigateUrl(
                                    "${controller.newsData!.data![index].newsUrl}");
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Commons.myGreenColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Column(
                        children: [
                          Text(
                            "No News Data Available",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'ColfaxBold'),
                          )
                        ],
                      ),
                    ),
            ],
          );
        }));
  }
}
