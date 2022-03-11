import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../enumeration/enumerations.dart';
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
    return SafeArea(
      child: Scaffold(
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
        body: _ExamPageView(),
      ),
    );
  }
}

class _ExamPageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(215, 250, 247, 1),
      ),
      child: Column(
        children: <Widget>[
          WidgetsHelper.appText(
            text: "乘法",
            fontWeight: FontWeight.w600,
          ),
          WidgetsHelper.appText(
            text: "運用乘法性質交換性質和結合性質進行乘法運算",
            size: WidgetSize.small,
          ),
          const SizedBox(height: 5,),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width / 3,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: WidgetsHelper.appText(
                        text: "題目",
                        size: WidgetSize.large,
                        fontColor: const Color.fromRGBO(204, 180, 0, 1),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15,),
                      child: WidgetsHelper.appText(text: "1", fontColor: Colors.white,),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: _DifficultyView(difficulty: 1,),
              ),

            ],
          ),
          const SizedBox(height: 10,),
          const Expanded(child: _SubmitForm(),),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class _DifficultyView extends StatelessWidget {

  final int _difficulty;

  const _DifficultyView({
    Key? key,
    required int difficulty,
  }) : _difficulty = difficulty, super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        WidgetsHelper.appText(text: "難度"),
        RatingBar.builder(
          initialRating: _difficulty.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          //itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => WidgetsHelper.appIcon(
            icon: Icons.star,
          ),
          itemSize: WidgetsHelper.widgetSize(size: WidgetSize.small,),
          onRatingUpdate: (rating) {},
        ),
      ],
    );
  }
}

class _SubmitForm extends StatelessWidget {

  const _SubmitForm({
    Key? key,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20,),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      WidgetsHelper.appText(text: "25 + 1 = "),
                      SizedBox(
                        height: WidgetsHelper.widgetSize(size: WidgetSize.normal,),
                        width: 50,
                        child: TextFormField(),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: WidgetsHelper.appText(
                      text: "提交回答",
                      fontColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}