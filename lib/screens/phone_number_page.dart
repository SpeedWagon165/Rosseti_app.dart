import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:rosseti_project/screens/sms_code_page.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: (120.0 * 2.91).h, top: 0.0, right: 35.0, left: 35.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 273),
              Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Телефон', // Устанавливаем подпись поля
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: (58 * 2.91).h,
                child: ElevatedButton(
                  onPressed: () {
                    DioBase().postData('some data', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SmsCodePage(),
                        ),
                      );
                    });
                  },
                  child: const Text(
                    'Далее',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
