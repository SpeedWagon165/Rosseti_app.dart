import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/screens/creation_page_1.dart';
import 'package:rosseti_project/widgets/base_appbar.dart';

import '../blocs/providers.dart';
import '../utils/project_theme_function.dart';

class CreationPageStart extends ConsumerWidget {
  const CreationPageStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(textProvider.notifier).state;
    final selectedTopicId = ref.watch(selectedTopicIdProvider.notifier).state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BaseAppBar(
              sureTextLow: true,
              isConditionMet: true,
              textLow: 'Расскажите о предложении',
              textLogo: 'Создать',
            ),
            SizedBox(height: (34.0 * 2.91).h),
            const Text('Выберите тему и название'),
            SizedBox(height: (34.0 * 2.91).h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: ChoiceTopic(
                      onTopicSelected: (int id) {
                        ref.read(selectedTopicIdProvider.notifier).state = id;
                      },
                    ),
                  ),
                  SizedBox(
                    height: (10.0 * 2.91).h,
                  ),
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'Название'),
                      onChanged: (value) =>
                          ref.read(textProvider.notifier).state = value,
                    ),
                  ),
                  SizedBox(height: (34.0 * 2.91).h),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (58 * 2.91).h,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(textProvider.notifier).state = text;
                        ref.read(selectedTopicIdProvider.notifier).state =
                            selectedTopicId;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CreationPage1(),
                          ),
                        );
                      },
                      child: const Text('Дальше'),
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
