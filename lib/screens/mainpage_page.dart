import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/screens/registration_page.dart';
import 'package:rosseti_project/widgets/bottoms_copy.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/screens/creation_page_start.dart';
import 'package:rosseti_project/screens/profile_page.dart';
import 'package:rosseti_project/screens/projects_page.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DioBase dioBase = DioBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Wrap(
            runSpacing: (32.0 * 2.91).h,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(height: (68.0 * 2.91).h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      DioBase().removeToken();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                      );
                    },
                    heroTag: 'bomb',
                    child: const Icon(Icons.arrow_back_outlined),
                  ),
                  Text('seti.inno',
                      style: Theme.of(context).textTheme.headlineMedium),
                  FloatingActionButton.small(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onPressed: () async {
                      final UserInfo? info = await dioBase.profileInfo();
                      if (!mounted) return;
                      if (info != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Status(info: info),
                          ),
                        );
                      } else {
                        const Text("Ошибка загрузки");
                        // Обработка случая, если информация о пользователе недоступна
                      }
                    },
                    heroTag: 'bombit',
                    child: Image.asset('assets/images/logo_rosseti.png'),
                  ),
                ],
              ),
              ManePageBottoms(
                  text: 'Создать предложение',
                  logo: 'assets/images/create_main_page.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreationPageStart(),
                      ),
                    );
                  }),
              ManePageBottoms(
                  text: 'Заявки',
                  logo: 'assets/images/idea_main_page.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProjectsPage(),
                      ),
                    );
                  }),
              ManePageBottoms(
                text: 'Экспертизы',
                logo: 'assets/images/skills_main_page.svg',
                onPressed: () {
                  forBottoms('3');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void forBottoms(String text) {
    debugPrint(text);
  }
}
