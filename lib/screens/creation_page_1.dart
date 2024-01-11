import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:rosseti_project/screens/video_player_example_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosseti_project/screens/profile_page.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'creation_page_2.dart';

class CreationPage1 extends StatefulWidget {
  final String title;
  final int topicId;

  const CreationPage1({Key? key, required this.title, required this.topicId})
      : super(key: key);

  @override
  State<CreationPage1> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreationPage1> {
  final TextEditingController textController = TextEditingController();
  DioBase dioBase = DioBase();
  late final String videoPath;

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return 'Ошибка';
      }
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  File? video;

  Future<Uint8List?> pickVideo(ImageSource source) async {
    final pickedVideo = await ImagePicker().pickVideo(source: source);
    if (pickedVideo == null) {
      return null;
    }
    final video = File(pickedVideo.path);
    videoPath = video.path;
    setState(() => this.video = video);
    return getVideoThumbnail(videoPath);
  }

  Future<Uint8List?> getVideoThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200,
      quality: 25,
    );
    return thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
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
                    child: Text('Расскажите как сейчас',
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
                  Center(
                    child: Text(
                      'Добавьте фото или видео',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Wrap(
                    spacing: (11 * 2.91).h,
                    children: [
                      image != null
                          ? Image.file(
                              image!,
                              width: (91.0 * 2.91).h,
                              height: (51.0 * 2.91).h,
                              fit: BoxFit.contain,
                            )
                          : const SizedBox(),
                      video != null
                          ? FutureBuilder<Uint8List?>(
                              future: getVideoThumbnail(videoPath),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    final thumbnail = snapshot.data;

                                    if (thumbnail != null) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoPlayerScreen(videoPath),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width:
                                              (91 * 2.91).h, // Ширина миниатюры
                                          height:
                                              (51 * 2.91).h, // Высота миниатюры
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: MemoryImage(thumbnail),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.play_circle_outline,
                                              size: (40 * 2.91).h,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }

                                return SizedBox(
                                  width: (91 * 2.91).h,
                                  height: (51 * 2.91).h,
                                  child: const Text(
                                      'Ошибка загрузки'), // Просто серый фон, можно заменить на свою заглушку
                                );
                              },
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: (43 * 2.91).h,
                        width: (43 * 2.91).h,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: SvgPicture.asset(
                              'assets/images/choose_photo.svg'),
                        ),
                      ),
                      SizedBox(
                        height: (43 * 2.91).h,
                        width: (43 * 2.91).h,
                        child: FloatingActionButton(
                          heroTag: "btn3",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            pickVideo(ImageSource.gallery);
                          },
                          child: SvgPicture.asset(
                              'assets/images/video_player_icon.svg'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: (31 * 2.91).h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: (58 * 2.91).h,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreationPage2(
                              title: widget.title,
                              topicId: widget.topicId,
                              text: textController.text,
                              video: video,
                              image: image,
                            )));
                  },
                  child: const Text(
                    'Дальше',
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
