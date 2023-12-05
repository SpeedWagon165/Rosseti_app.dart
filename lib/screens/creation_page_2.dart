import 'package:flutter/material.dart';
import 'package:rosseti_project/screens/creation_page_3.dart';

import 'package:rosseti_project/Models/CreationPage_Shablon.dart';

class CreationPage2 extends StatelessWidget {
  const CreationPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreationShablon(
        text: 'Создать',
        textLow: 'Расскажите как надо',
        buttonText: 'Дальше',
        isConditionMet: true,
        next: CreationPage3(),
        blocType: 2,
      ),
    );
  }
}
