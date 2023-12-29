import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/Blocs/send_messege_bloc.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

class ChoiceTopic extends StatefulWidget {
  final Function(int) onTopicSelected;

  const ChoiceTopic({Key? key, required this.onTopicSelected})
      : super(key: key);

  @override
  State<ChoiceTopic> createState() => _ChoiceTopicState();
}

class _ChoiceTopicState extends State<ChoiceTopic> {
  List<Map<String, dynamic>> topics = [];
  DioBase dioBase = DioBase();
  String selectedTheme = '';

  Future<void> fetchDataFromServer() async {
    try {
      final response = await dioBase.dio.get('/topics');
      final responseData = response.data;

      List<Map<String, dynamic>> newTopics =
          List<Map<String, dynamic>>.from(responseData['topics']);

      setState(() {
        topics = newTopics;
      });
    } catch (error) {
      debugPrint('Ошибка при загрузке данных: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openCitySelection(context);
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Тема проекта',
            suffixIcon: InkWell(
                onTap: () {
                  _openCitySelection(context);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: (5.0 * 2.91).h, horizontal: 25.0),
                    child: SvgPicture.asset(
                        'assets/images/arrow_for_theme_choise.svg'))),
          ),
          controller: TextEditingController(text: selectedTheme),
          onChanged: (value) {
            setState(() {
              selectedTheme = value;
            });
          },
        ),
      ),
    );
  }

  void _openCitySelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: (200 * 2.91).h,
          child: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              return ListTile(
                title: Text(topic['title'] ?? ''),
                onTap: () {
                  setState(() {
                    selectedTheme = topic['title'] ?? '';
                  });
                  final selectedId = topic['id'];
                  widget.onTopicSelected(selectedId);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
