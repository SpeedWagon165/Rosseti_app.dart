import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/creation_page_1.dart';
import 'package:rosseti_project/Models/osnova_sozdania.dart';
import 'package:rosseti_project/logic/project_theme_function.dart';
import 'package:rosseti_project/profile.dart';

class CreationPageStart extends StatefulWidget {
  const CreationPageStart({super.key});

  @override
  State<CreationPageStart> createState() => _CreationPageStartState();
}

class _CreationPageStartState extends State<CreationPageStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ApperBar(
              suretextLow: true,
              isConditionMet: true,
              textLow: 'Расскажите о предложении',
              textLogo: 'Создать',
            ),
            const SizedBox(
              height: 34.0,
            ),
            const Text('Выберите тему и название'),
            const SizedBox(
              height: 34.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextFielder(),
                  ),
                  const SizedBox(
                    height: 34.0,
                  ),
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Название',
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 213,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CreationPage1(),
                          ),
                        );
                      },
                      child: const Text(
                        'Дальше',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
