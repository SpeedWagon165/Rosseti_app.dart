import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:rosseti_project/screens/profile_page.dart';

class BaseAppBar extends StatefulWidget {
  const BaseAppBar({
    Key? key,
    required this.textLogo,
    required this.textLow,
    required this.isConditionMet,
    required this.suretextLow,
    this.statusButton,
  }) : super(key: key);
  final String textLogo;
  final String textLow;
  final bool isConditionMet;
  final bool suretextLow;
  final dynamic statusButton;

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  DioBase dioBase = DioBase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(height: 68),
          Wrap(
              runSpacing: 17.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isConditionMet
                        ? FloatingActionButton.small(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset('assets/Arrow_back.svg'))
                        : const SizedBox(
                            width: 48.0,
                          ),
                    Text(widget.textLogo,
                        style: Theme.of(context).textTheme.headlineMedium),
                    FloatingActionButton.small(
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
                    ),
                  ],
                ),
                if (widget.suretextLow)
                  Center(
                    child: Text(widget.textLow,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
              ]),
        ]),
      ),
    );
  }
}