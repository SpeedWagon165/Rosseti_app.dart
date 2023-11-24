import 'package:flutter/material.dart';
import 'package:rosseti_project/Models/bottoms_copy.dart';
import 'package:rosseti_project/creation_page_start.dart';
import 'package:rosseti_project/profile.dart';
import 'package:rosseti_project/projects.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
                  const SizedBox(
                    width: 34.0,
                  ),
                  Text('seti.inno',
                      style: Theme.of(context).textTheme.headlineMedium),
                  FloatingActionButton.small(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Status(),
                          ),
                        );
                      },
                      child: Image.asset('assets/sharos.png')),
                ],
              ),
              Bottoms(
                  text: 'Создать предложение',
                  logo: 'assets/create_1.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreationPageStart(),
                      ),
                    );
                  }),
              Bottoms(
                  text: 'Заявки',
                  logo: 'assets/idea_1.svg',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Projects(),
                      ),
                    );
                  }),
              Bottoms(
                  text: 'Экспертизы',
                  logo: 'assets/skills_1.svg',
                  onPressed: () {
                    forBottoms('3');
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void forBottoms(String text) {
    print(text);
  }
}
