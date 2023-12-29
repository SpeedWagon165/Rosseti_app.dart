import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectBottoms extends StatelessWidget {
  const ProjectBottoms({
    Key? key,
    required this.projectName,
    required this.logo,
    required this.onPressed,
  }) : super(key: key);
  final String projectName;
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
        child: SizedBox(
          height: 358.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: (30 * 2.91).h, horizontal: (10.0 * 2.91).h),
                  child: SvgPicture.asset(logo)),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: (12.0 * 2.91).h, horizontal: (10.0 * 2.91).h),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: (200.0 * 2.91).h),
                          child: Text(projectName,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: (200.0 * 2.91).h),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'data',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'ABeeZee',
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: (200.0 * 2.91).h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'data',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      )
                    ],
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
