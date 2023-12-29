import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/widgets/base_appbar.dart';
import 'package:rosseti_project/widgets/project_botton_copy.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            textLogo: 'Проекты',
            textLow: 'Боба',
            isConditionMet: true,
            sureTextLow: false,
          ),
          const SizedBox(height: 21.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (20.0 * 2.91).h),
            child: Column(
              children: [
                ProjectBottoms(
                  projectName: 'Название проекта asdasdasdasdasdasd',
                  logo: 'assets/create_main_page.svg',
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
