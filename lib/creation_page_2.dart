import 'package:flutter/material.dart';
import 'package:rosseti_project/creation_page_3.dart';

import 'Shablons/CreationPage_Shablon.dart';

class CreationPage2 extends StatelessWidget {
  const CreationPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreationShablon(
        text: 'Создать',
        textLow: 'Расскажите как надо',
        buttonText: 'Дальше',
        isConditionMet: true,
        next: CreationPage3(),
      ),

    );
  }
}
