import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bottoms extends StatelessWidget {
  const Bottoms({
    Key? key,
    required this.text,
    required this.logo,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final String logo;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Material(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(logo),
              Flexible(
                child: SizedBox(
                  width: 150,
                  child: Text(text,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
