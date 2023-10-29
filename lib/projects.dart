import 'package:flutter/material.dart';
import 'package:rosseti_project/Shablons/osnova_sozdania.dart';
import 'package:rosseti_project/Shablons/project_botton_copy.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ApperBar(
            textLogo: 'Проекты',
            textLow: 'Боба',
            isConditionMet: true,
            suretextLow: false,
          ),
          const SizedBox(height: 21.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                ProjectBottoms(
                  projectName: 'Название проекта asdasdasdasdasdasd',
                  logo: 'assets/create_1.svg',
                  onPressed: () {
                    print('2');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
