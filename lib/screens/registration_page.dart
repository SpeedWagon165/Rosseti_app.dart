import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/screens/phone_number_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 400.h),
          SizedBox(
            height: 500.h,
            child: Image.asset('assets/images/logo_rosseti.png'),
          ),
          SizedBox(height: 70.h),
          Text(
            'seti.inno',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 55.h),
          const Text(
            'Рацианализатор',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'ABeeZee',
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: (120.0 * 2.91).h,
            top: 0.0,
            right: (35.0 * 2.91).h,
            left: (35.0 * 2.91).h),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: (58 * 2.91).h,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PhoneNumberPage(),
                ),
              );
            },
            child: const Text(
              'Регистрация',
            ),
          ),
        ),
      ),
    );
  }
}
