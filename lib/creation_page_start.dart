import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/creation_page_1.dart';
import 'package:rosseti_project/Models/osnova_sozdania.dart';
import 'package:rosseti_project/logic/project_theme_function.dart';
import 'package:rosseti_project/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rosseti_project/repositories/send_solution.dart';

class CreationPageStart extends ConsumerWidget {
  CreationPageStart({Key? key}) : super(key: key);

  final TextEditingController textController = TextEditingController();
  final SendSolution solution = SendSolution();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    child: const TextFielder(),
                  ),
                  const SizedBox(
                    height: 34.0,
                  ),
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextField(
                      controller: textController,
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
                        ref.read(solution.titleProvider.notifier).state =
                            textController.text;
                        print(ref.watch(solution.titleProvider));
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
