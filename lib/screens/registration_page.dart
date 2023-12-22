import 'package:flutter/material.dart';
import 'package:rosseti_project/screens/phone_number_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          const SizedBox(height: 151.0),
          Image.asset('assets/logo_rosseti.png'),
          const SizedBox(height: 30.0),
          Text(
            'seti.inno',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20.0),
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
        padding: const EdgeInsets.only(
            bottom: 120.0, top: 0.0, right: 35.0, left: 35.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 58,
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
