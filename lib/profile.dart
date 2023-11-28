import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rosseti_project/Models/osnova_sozdania.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ApperBar(
            textLogo: 'Мой статус',
            textLow: 'Бонжур',
            isConditionMet: false,
            suretextLow: false,
            statusButton: true,
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: SvgPicture.asset(
              'assets/crowns_1.svg',
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) => const ListTile(
                  title: Text('Bu'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
