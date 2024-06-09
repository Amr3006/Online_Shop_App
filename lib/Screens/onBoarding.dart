import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/loginPage.dart';
import 'package:shop/Shared/CacheHelper.dart';
import 'package:shop/Shared/Components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatelessWidget {
  var pagecontroller = PageController();

  List<boardItem> boards = [
    boardItem(
        image: "assets/images/onboard1.png", title: "Title 1", body: "Body 1"),
    boardItem(
        image: "assets/images/onboard2.png", title: "Title 2", body: "Body 2"),
    boardItem(
        image: "assets/images/onboard3.png", title: "Title 3", body: "Body 3"),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                navigateToAndErease(context: context, widget: loginScreen());
                cacheHelper.saveData(key: "onBoarding", value: true);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "SKIP",
                  style: TextStyle(fontSize: 20),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boards.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                controller: pagecontroller,
                itemBuilder: (context, index) =>
                    onboard(context: context, board: boards[index]),
                itemCount: boards.length,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pagecontroller,
                  count: boards.length,
                  effect: const ExpandingDotsEffect(activeDotColor: Colors.pink),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == false) {
                      pagecontroller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn);
                    } else {
                      navigateToAndErease(
                          context: context, widget: loginScreen());
                      cacheHelper.saveData(key: "onBoarding", value: true);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

Widget onboard({required BuildContext context, required boardItem board}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(board.image)),
        const SizedBox(
          height: 20,
        ),
        Text(
          board.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          board.body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );

class boardItem {
  final String image;
  final String title;
  final String body;

  boardItem({required this.image, required this.title, required this.body});
}
