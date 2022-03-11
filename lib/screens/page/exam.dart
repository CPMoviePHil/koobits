import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobits_exam/api/api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../enumeration/enumerations.dart';
import '../../utils/utils.dart';
import '../../blocs/blocs.dart';
import '../../models/models.dart';

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
      body: Scaffold(
        body: _ExamPageView(pageController: _pageController,),
      ),
    );
  }
}

class _ExamPageView extends StatelessWidget {

  final PageController pageController;
  const _ExamPageView({Key? key, required this.pageController,}) : super(key: key,);

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
          BlocBuilder<QuestionCubit, ApiResponse>(
            buildWhen: (prev, next) => prev != next,
            builder: (context, state) {
              switch (state.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.ERROR:
                  return Container();
                case Status.COMPLETED:
                  final List<QuestionModel> data = state.data;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
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
                                      child: WidgetsHelper.appText(text: "${index + 1}", fontColor: Colors.white,),
                                    ),
                                  ],
                                ),
                                BlocBuilder<QuestionCubit, ApiResponse>(
                                  builder: (context, state) {
                                    switch (state.status) {
                                      case Status.LOADING:
                                        return const CircularProgressIndicator();
                                      case Status.ERROR:
                                        return Container();
                                      case Status.COMPLETED:
                                        final List<QuestionModel> data = state.data;
                                        return _DifficultyView(difficulty: data[index].difficulty,);
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Expanded(
                              child: _SubmitForm(
                                questionModel: data[index],
                              ),
                            ),
                            const SizedBox(height: 10,),
                          ],
                        );
                      },
                    ),
                  );
              }
            },
          ),
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
      mainAxisAlignment: MainAxisAlignment.center,
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
    required this.questionModel,
  }) : super(key: key,);

  final QuestionModel questionModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40,),
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
                      WidgetsHelper.appText(text: questionModel.question),
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