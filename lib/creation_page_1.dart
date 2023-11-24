import 'package:flutter/material.dart';
import 'package:rosseti_project/creation_page_2.dart';
import 'Models/CreationPage_Shablon.dart';

class CreationPage1 extends StatelessWidget {
  const CreationPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CreationShablon(
          text: 'Создать',
          textLow: 'Расскажите как сейчас',
          buttonText: 'Дальше',
          isConditionMet: true,
          next: CreationPage2(),
        ),
      ),
    );
  }
}
