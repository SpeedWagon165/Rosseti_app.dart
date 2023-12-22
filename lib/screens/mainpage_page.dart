import 'package:flutter/material.dart';
import 'package:rosseti_project/screens/registration_page.dart';
import 'package:rosseti_project/widgets/bottoms_copy.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/screens/creation_page_start.dart';
import 'package:rosseti_project/main.dart';
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
            runSpacing: 32.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              const SizedBox(height: 68.0),
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
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Dialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        );

                        final UserInfo? info = await dioBase.profileInfo();

                        Navigator.pop(
                            context); // Закрываем диалоговое окно загрузки

                        if (info != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Status(info: info),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Ошибка загрузки'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      heroTag: 'bombit',
                      child: Image.asset('assets/logo_rosseti.png')),
                ],
              ),
              ManePageBottoms(
                  text: 'Создать предложение',
                  logo: 'assets/create_main_page.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreationPageStart(),
                      ),
                    );
                  }),
              ManePageBottoms(
                  text: 'Заявки',
                  logo: 'assets/idea_main_page.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProjectsPage(),
                      ),
                    );
                  }),
              ManePageBottoms(
                text: 'Экспертизы',
                logo: 'assets/skills_main_page.svg',
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
