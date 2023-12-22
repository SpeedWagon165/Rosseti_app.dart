import 'package:flutter/material.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:rosseti_project/screens/profile_page.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton({Key? key, required this.statusButton}) : super(key: key);
  final dynamic statusButton;

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  DioBase dioBase = DioBase();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: "btn1",
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () async {
        if (widget.statusButton != null) {
          Navigator.of(context).pop();
        } else {
          final UserInfo? info = await dioBase.profileInfo();
          if (info != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Status(info: info),
              ),
            );
          } else {
            const Text("Ошибка загрузки");
            // Обработка случая, если информация о пользователе недоступна
          }
        }
      },
      child: Image.asset('assets/logo_rosseti.png'),
    );
  }
}
