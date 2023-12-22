import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/Blocs/send_messege_bloc.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

class TextFielder extends StatefulWidget {
  const TextFielder({super.key});

  @override
  State<TextFielder> createState() => _TextFielderState();
}

class _TextFielderState extends State<TextFielder> {
  List<Map<String, dynamic>> topics = [];
  DioBase phoneNumberCheker = DioBase();
  String selectedTheme = '';

  @override
  void initState() {
    super.initState();
    phoneNumberCheker.fetchDataFromServer(updateState);
  }

  void updateState(List<Map<String, dynamic>> newTopics) {
    setState(() {
      topics = newTopics;
    });
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 25.0),
                    child:
                        SvgPicture.asset('assets/arrow_for_theme_choise.svg'))),
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
          height: 200,
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
                  BlocProvider.of<TopicBloc>(context)
                      .add(TopicEvent(selectedId));
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
