import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFielder extends StatefulWidget {
  const TextFielder({super.key});

  @override
  State<TextFielder> createState() => _TextFielderState();
}

class _TextFielderState extends State<TextFielder> {
  final List<String> cities = [
    'Общее',
    'Миста Саливан',
    'Окрошка',
    'Окорочёк',
    'Бычий СПИД'
  ];
  String selectedCity = '';

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
          controller: TextEditingController(text: selectedCity),
          onChanged: (value) {
            setState(() {
              selectedCity = value;
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
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(cities[index]),
                onTap: () {
                  setState(() {
                    selectedCity = cities[index];
                  });
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
