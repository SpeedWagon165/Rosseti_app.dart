import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/Blocs/send_messege_bloc.dart';
import 'package:rosseti_project/screens/creation_page_1.dart';
import 'package:rosseti_project/widgets/base_appbar.dart';
import 'package:rosseti_project/utils/project_theme_function.dart';

class CreationPageStart extends StatefulWidget {
  const CreationPageStart({Key? key}) : super(key: key);

  @override
  State<CreationPageStart> createState() => _CreationPageStartState();
}

class _CreationPageStartState extends State<CreationPageStart> {
  final TextEditingController textController = TextEditingController();
  int selectedTopicId = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: (34.0 * 2.91).h,
            ),
            const Text('Выберите тему и название'),
            SizedBox(
              height: (34.0 * 2.91).h,
            ),
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
                        setState(() {
                          selectedTopicId = id;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: (34.0 * 2.91).h,
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
                  SizedBox(
                    height: (213 * 2.91).h,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (58 * 2.91).h,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<TitleBloc>(context)
                            .add(TitleEvent(textController.text));

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreationPage1(
                              title: textController.text,
                              topicId: selectedTopicId,
                            ),
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
