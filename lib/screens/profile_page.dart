import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rosseti_project/widgets/base_appbar.dart';
import 'package:rosseti_project/models/profile_json.dart';

class Status extends StatelessWidget {
  final UserInfo info;

  const Status({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight((100.0 * 2.91).h),
        child: const BaseAppBar(
          sureTextLow: false,
          isConditionMet: false,
          textLow: 'Расскажите о предложении',
          textLogo: 'Мой статус',
          statusButton: 1,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: (35.0 * 2.91).h),
        children: [
          SizedBox(
            height: (150 * 2.91).h,
            width: (150 * 2.91).h,
            child: SvgPicture.asset(
              'assets/images/crown_profile.svg',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            height: (30.0 * 2.91).h,
            child: Text('Серебряный статус',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: const Text('Оценок'),
              trailing: Text(info.ratingsCount.toString())),
          ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: const Text('Комментариев'),
              trailing: Text(info.commentsCount.toString())),
          ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: const Text('Предложений'),
              trailing: Text(info.proposalsCount.toString())),
          ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: const Text('Одобрено'),
              trailing: Text(info.acceptedProposalsCount.toString())),
          const SizedBox(height: 10.0),
          SizedBox(
              height: (30.0 * 2.91).h,
              child: Text(
                'Итого 1300 бонусов',
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: (22.0 * 2.91).h,
          ),
          SizedBox(
            height: (100.0 * 2.91).h,
            child: Text(
              'До золотого статуса ещё ${(45 - info.ratingsCount).toString()} оценок или ${(31 - info.commentsCount).toString()} комментариев или ${(5 - info.proposalsCount).toString()} предложений',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: (30.0 * 2.91).h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (58 * 2.91).h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Готово',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
