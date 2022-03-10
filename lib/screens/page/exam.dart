import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/utils.dart';

class ExamPage extends StatefulWidget {

  const ExamPage({
    Key? key,
  }) : super(key: key,);

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {

  final _pageController = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(44, 17, 242, 1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            WidgetsHelper.appText(
              text: "完成10道題目可解鎖獎勵",
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5,),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5,),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromRGBO(118, 99, 255, 1),
              ),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 10,
                effect: const ScrollingDotsEffect(
                  dotColor: Colors.white,
                  activeDotScale: 1.0,
                  maxVisibleDots: 11,
                  radius: 8,
                  spacing: 6,
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExamPageView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}