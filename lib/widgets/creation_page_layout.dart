import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:rosseti_project/screens/video_player_example_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosseti_project/screens/profile_page.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../blocs/providers.dart';

class CreationShablon extends ConsumerWidget {
  final String text;
  final String buttonText;
  final String textLow;
  final dynamic next;
  final bool isConditionMet;
  final int blocType;

  CreationShablon({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.textLow,
    required this.next,
    required this.isConditionMet,
    required this.blocType,
  }) : super(key: key);

  final TextEditingController textController = TextEditingController();
  final dioBase = DioBase();
  late final String videoPath;

  Future pickImage(WidgetRef ref, ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        print('No image selected.');
        return;
      }
      final imageTemporary = File(pickedImage.path);
      ref.read(existingImageProvider.notifier).state = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> pickVideo(WidgetRef ref, ImageSource source) async {
    try {
      final pickedVideo = await ImagePicker().pickVideo(source: source);
      if (pickedVideo == null) {
        print('No video selected.');
        return;
      }
      final videoFile = File(pickedVideo.path);
      ref.read(existingVideoProvider.notifier).state = videoFile;

      videoPath = videoFile.path;

      final thumbnail = await getVideoThumbnail(videoPath);
      ref.read(videoThumbnailProvider.notifier).state = thumbnail;
    } on PlatformException catch (e) {
      print('Failed to pick video: $e');
    }
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
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(textProvider.notifier).state;
    final topicId = ref.watch(selectedTopicIdProvider.notifier).state;
    final image = ref.watch(existingImageProvider);
    final video = ref.watch(existingVideoProvider);
    final thumbnaill = ref.watch(videoThumbnailProvider.notifier).state;
    return Padding(
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
                    Text(text,
                        style: Theme.of(context).textTheme.headlineMedium),
                    FloatingActionButton.small(
                      heroTag: "btn1",
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: () async {
                        final UserInfo? info = await dioBase.profileInfo();
                        if (info != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Status(info: info),
                            ),
                          );
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
                  child: Text(textLow,
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
                if (isConditionMet)
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
                            image,
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
                    if (isConditionMet)
                      SizedBox(
                        height: (43 * 2.91).h,
                        width: (43 * 2.91).h,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            pickImage(ref, ImageSource.gallery);
                          },
                          child: SvgPicture.asset(
                              'assets/images/choose_photo.svg'),
                        ),
                      ),
                    if (isConditionMet)
                      SizedBox(
                        height: (43 * 2.91).h,
                        width: (43 * 2.91).h,
                        child: FloatingActionButton(
                          heroTag: "btn3",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            pickVideo(ref, ImageSource.gallery);
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
                  if (blocType == 1) {
                    ref.read(existingVideoProvider.notifier).state = video;
                    ref.read(existingImageProvider.notifier).state = image;
                    ref.read(existingTextProvider.notifier).state =
                        textController.text;
                  }
                  if (blocType == 2) {
                    ref.watch(proposedVideoProvider.notifier).state = video;
                    ref.watch(proposedImageProvider.notifier).state = image;
                    ref.watch(proposedTextProvider.notifier).state =
                        textController.text;
                  }
                  if (blocType == 3) {
                    ref.read(positiveEffectTextProvider.notifier).state =
                        textController.text;
                    final formData = FormData.fromMap({
                      'title': title,
                      'topic_id': topicId,
                      'existing_solution_text': ref.watch(existingTextProvider),
                      'existing_solution_image':
                          ref.watch(existingImageProvider),
                      'existing_solution_video':
                          ref.watch(existingVideoProvider),
                      'proposed_solution_text': ref.watch(proposedTextProvider),
                      'proposed_solution_image':
                          ref.watch(proposedImageProvider),
                      'proposed_solution_video':
                          ref.watch(proposedVideoProvider),
                      'positive_effect': ref.watch(positiveEffectTextProvider),
                    });

                    final dataToSend = Map<String, dynamic>.fromEntries(
                      formData.fields.map((e) => MapEntry(e.key, e.value)),
                    );

                    dioBase.sendData(dataToSend);
                  }

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => next));
                },
                child: Text(
                  buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
