import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rosseti_project/screens/profile_page.dart';
import '../models/json_response_convert.dart';
import 'mainpage_page.dart';
import 'dart:io';

class CreationPage3 extends StatefulWidget {
  final String title;
  final int topicId;
  final String text;
  final File? image;
  final File? video;
  final String propText;
  final File? propImage;
  final File? propVideo;

  const CreationPage3({
    required this.title,
    required this.topicId,
    required this.text,
    this.image,
    this.video,
    required this.propText,
    this.propImage,
    this.propVideo,
    Key? key,
  }) : super(key: key);

  @override
  State<CreationPage3> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreationPage3> {
  final TextEditingController textController = TextEditingController();
  DioBase dioBase = DioBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            SizedBox(height: (68 * 2.91).h),
            Wrap(
              runSpacing: (17.0 * 2.91).h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton.small(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:
                            SvgPicture.asset('assets/images/arrow_back.svg')),
                    Text('Создать',
                        style: Theme.of(context).textTheme.headlineMedium),
                    FloatingActionButton.small(
                      heroTag: "btn1",
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: () async {
                        final UserInfo? info = await dioBase.profileInfo();
                        if (info != null) {
                          if (mounted) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Status(info: info),
                              ),
                            );
                          }
                        } else {
                          const Text("Ошибка загрузки");
                          // Обработка случая, если информация о пользователе недоступна
                        }
                      },
                      child: Image.asset('assets/images/logo_rosseti.png'),
                    ),
                  ],
                ),
                Center(
                  child: Text('Расскажите как будет',
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                SizedBox(
                  height: (292.0 * 2.91).h,
                  child: Material(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextField(
                      controller: textController,
                      minLines: 20,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: (31 * 2.91).h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: (58 * 2.91).h,
                  child: ElevatedButton(
                    onPressed: () async {
                      AllBlocksData allBlocksData = AllBlocksData(
                        titleValue: widget.title,
                        topicValue: widget.topicId,
                        existingTextValue: widget.text,
                        existingImageValue: widget.image,
                        existingVideoValue: widget.video,
                        proposedTextValue: widget.propText,
                        proposedImageValue: widget.propImage,
                        proposedVideoValue: widget.propVideo,
                        positiveEffectValue: textController.text,
                      );

                      FormData formData =
                          await FormDataHelper.createFormData(allBlocksData);
                      dioBase.sendData(formData);
                      if (mounted) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MainPage()));
                      }
                    },
                    child: const Text(
                      'Готово',
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
