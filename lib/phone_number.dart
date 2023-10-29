import 'package:flutter/material.dart';
import 'package:rosseti_project/SMS_code.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            bottom: 120.0, top: 0.0, right: 35.0, left: 35.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 273),
            Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: TextField(
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
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SMScode(),
                    ),
                  );
                },
                child: const Text(
                  'Далее',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CryptoCoinsRepository().getCoinList();
        },
        heroTag: 'bombitka',
      ),
    );
  }
}
