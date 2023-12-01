import 'package:flutter/material.dart';
import 'package:rosseti_project/screens/mainpage.dart';

import 'package:rosseti_project/Models/CreationPage_Shablon.dart';

class CreationPage3 extends StatelessWidget {
  const CreationPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreationShablon(
        text: 'Создать',
        textLow: 'Расскажите как будет',
        buttonText: 'Готово',
        isConditionMet: false,
        next: MainPage(),
      ),
    );
  }
}