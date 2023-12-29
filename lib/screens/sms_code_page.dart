import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

import 'mainpage_page.dart';

class SmsCodePage extends StatefulWidget {
  const SmsCodePage({super.key});

  @override
  State<SmsCodePage> createState() => _SmsCodePageState();
}

class _SmsCodePageState extends State<SmsCodePage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: (120.0 * 2.91).h,
            top: 0.0,
            right: 35.0,
            left: (35.0 * 2.91).h),
        child: Column(
          children: <Widget>[
            SizedBox(height: (273 * 2.91).h),
            Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Код из СМС',
                ),
                onChanged: (value) {
                  // Обработка изменения значения поля
                },
              ),
            ),
            SizedBox(height: (17 * 2.91).h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: (58 * 2.91).h,
              child: ElevatedButton(
                onPressed: () {
                  DioBase().postPhoneCode(textController.text, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  });
                  debugPrint(textController.text);
                },
                child: const Text(
                  'Готово',
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
