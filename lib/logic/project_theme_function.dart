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
  PhoneNumberCheker phoneNumberCheker = PhoneNumberCheker();
  String selectedTheme = '';

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    // Здесь вызываете метод для получения данных с сервера
    // Например, с использованием Dio
    try {
      // Выполняем запрос на сервер
      final response = await phoneNumberCheker.dio.get('/topics');

      // Парсим полученные данные
      final responseData = response.data;

      setState(() {
        topics = List<Map<String, dynamic>>.from(responseData['topics']);
      });
    } catch (error) {
      // Обрабатываем ошибку при получении данных
      print('Ошибка при загрузке данных: $error');
    }
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
                    child: SvgPicture.asset('assets/Vector.svg'))),
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
