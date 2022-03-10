import 'package:flutter/material.dart';

class ExamPage extends StatelessWidget {

  const ExamPage({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text("完成10道題目可解鎖獎勵"),

          ],
        ),
      ),
    );
  }
}