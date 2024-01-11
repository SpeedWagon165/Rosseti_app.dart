import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    required this.sureTextLow,
    this.statusButton,
  }) : super(key: key);
  final String textLogo;
  final String textLow;
  final bool isConditionMet;
  final bool sureTextLow;
  final dynamic statusButton;

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  DioBase dioBase = DioBase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (35.0 * 2.91).h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(height: (68 * 2.91).h),
          Wrap(
              runSpacing: (17.0 * 2.91).h,
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
                            child: SvgPicture.asset(
                                'assets/images/arrow_back.svg'))
                        : SizedBox(
                            width: (48.0 * 2.91).h,
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
                            if (mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Status(info: info),
                                ),
                              );
                            }
                          } else {
                            const Text("Ошибка загрузки");
                            // Обработка случая, если информация о пользователе недоступна
                          }
                        }
                      },
                      child: Image.asset('assets/images/logo_rosseti.png'),
                    ),
                  ],
                ),
                if (widget.sureTextLow)
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
