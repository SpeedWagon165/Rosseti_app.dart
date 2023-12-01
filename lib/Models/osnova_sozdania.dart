import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/screens/profile.dart';

class ApperBar extends StatelessWidget {
  const ApperBar({
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(height: 68),
          Wrap(
              runSpacing: 17.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isConditionMet
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
                    Text(textLogo,
                        style: Theme.of(context).textTheme.headlineMedium),
                    FloatingActionButton.small(
                      heroTag: "btn1",
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: () {
                        if (statusButton != null) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Status()),
                          );
                        }
                      },
                      child: Image.asset('assets/sharos.png'),
                    ),
                  ],
                ),
                if (suretextLow)
                  Center(
                    child: Text(textLow,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
              ]),
        ]),
      ),
    );
  }
}
