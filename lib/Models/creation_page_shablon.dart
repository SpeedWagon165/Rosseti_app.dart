import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rosseti_project/Blocs/send_messege_bloc.dart';
import 'package:rosseti_project/repositories/profile_json.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';
import 'package:rosseti_project/screens/Video_player_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosseti_project/screens/profile.dart';
import 'package:rosseti_project/repositories/send_solution.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreationShablon extends StatefulWidget {
  const CreationShablon({
    Key? key,
    required this.text,
    required this.textLow,
    required this.next,
    required this.isConditionMet,
    required this.buttonText,
    required this.blocType,
  }) : super(key: key);
  final String text;
  final String buttonText;
  final String textLow;
  final dynamic next;
  final bool isConditionMet;
  final int blocType;

  @override
  State<CreationShablon> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreationShablon> {
  final TextEditingController textController = TextEditingController();
  PhoneNumberCheker phoneNumberCheker = PhoneNumberCheker();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 68),
            Wrap(
              runSpacing: 17.0,
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
                        child: SvgPicture.asset('assets/Arrow_back.svg')),
                    Text(widget.text,
                        style: Theme.of(context).textTheme.headlineMedium),
                    FloatingActionButton.small(
                      heroTag: "btn1",
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      onPressed: () async {
                        final UserInfo? info =
                            await phoneNumberCheker.profileInfo();
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
                      child: Image.asset('assets/sharos.png'),
                    ),
                  ],
                ),
                Center(
                  child: Text(widget.textLow,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                SizedBox(
                  height: 292.0,
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
                if (widget.isConditionMet)
                  Center(
                    child: Text(
                      'Добавьте фото или видео',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                Wrap(
                  spacing: 11,
                  children: [
                    image != null
                        ? Image.file(
                            image!,
                            width: 91.0,
                            height: 51.0,
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
                                        width: 91, // Ширина миниатюры
                                        height: 51, // Высота миниатюры
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(thumbnail),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.play_circle_outline,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }

                              return const SizedBox(
                                width: 91,
                                height: 51,
                                child: Text(
                                    'Ошибка загрузки'), // Просто серый фон, можно заменить на свою заглушку
                              );
                            },
                          )
                        : const SizedBox(),
                    if (widget.isConditionMet)
                      SizedBox(
                        height: 43,
                        width: 43,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: SvgPicture.asset('assets/take 1.svg'),
                        ),
                      ),
                    if (widget.isConditionMet)
                      SizedBox(
                        height: 43,
                        width: 43,
                        child: FloatingActionButton(
                          heroTag: "btn3",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            pickVideo(ImageSource.gallery);
                          },
                          child: SvgPicture.asset('assets/video-player 1.svg'),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 31,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 58,
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.blocType == 1) {
                    BlocProvider.of<ExistingTextBloc>(context)
                        .add(ExistingTextEvent(textController.text));
                    BlocProvider.of<ExistingImageBloc>(context)
                        .add(ExistingImageEvent(image));
                    BlocProvider.of<ExistingVideoBloc>(context)
                        .add(ExistingVideoEvent(video));
                  }
                  if (widget.blocType == 2) {
                    BlocProvider.of<ProposedTextBloc>(context)
                        .add(ProposedTextEvent(textController.text));
                    BlocProvider.of<ProposedImageBloc>(context)
                        .add(ProposedImageEvent(image));
                    BlocProvider.of<ProposedVideoBloc>(context)
                        .add(ProposedVideoEvent(video));
                  }
                  if (widget.blocType == 3) {
                    BlocProvider.of<PositiveEffectBloc>(context)
                        .add(PositiveEffectEvent(textController.text));
                    final titleBlocState =
                        BlocProvider.of<TitleBloc>(context).state;
                    final topicBlocState =
                        BlocProvider.of<TopicBloc>(context).state;
                    final existingTextBlocState =
                        BlocProvider.of<ExistingTextBloc>(context).state;
                    final existingImageBlocState =
                        BlocProvider.of<ExistingImageBloc>(context).state;
                    final existingVideoBlocState =
                        BlocProvider.of<ExistingVideoBloc>(context).state;
                    final proposedTextBlocState =
                        BlocProvider.of<ProposedTextBloc>(context).state;
                    final proposedImageBlocState =
                        BlocProvider.of<ProposedImageBloc>(context).state;
                    final proposedVideoBlocState =
                        BlocProvider.of<ProposedVideoBloc>(context).state;
                    final positiveEffectBlocState =
                        BlocProvider.of<PositiveEffectBloc>(context).state;

                    final allBlocksData = AllBlocksData(
                      titleValue: (titleBlocState is TitleState)
                          ? titleBlocState.title
                          : '',
                      topicValue: (topicBlocState is TopicState)
                          ? topicBlocState.topic
                          : 0,
                      existingTextValue:
                          (existingTextBlocState is ExistingTextState)
                              ? existingTextBlocState.existingText
                              : '',
                      existingImageValue:
                          (existingImageBlocState is ExistingImageState)
                              ? existingImageBlocState.existingImage
                              : null,
                      existingVideoValue:
                          (existingVideoBlocState is ExistingVideoState)
                              ? existingVideoBlocState.existingVideo
                              : null,
                      proposedTextValue:
                          (proposedTextBlocState is ProposedTextState)
                              ? proposedTextBlocState.proposedText
                              : '',
                      proposedImageValue:
                          (proposedImageBlocState is ProposedImageState)
                              ? proposedImageBlocState.proposedImage
                              : null,
                      proposedVideoValue:
                          (proposedVideoBlocState is ProposedVideoState)
                              ? proposedVideoBlocState.proposedVideo
                              : null,
                      positiveEffectValue:
                          (positiveEffectBlocState is PositiveEffectState)
                              ? positiveEffectBlocState.positiveEffect
                              : '',
                    );
                    final formData = FormData.fromMap({
                      'title': allBlocksData.titleValue,
                      'topic_id': allBlocksData.topicValue,
                      'existing_solution_text': allBlocksData.existingTextValue,
                      'existing_solution_image': await MultipartFile.fromFile(
                        allBlocksData.existingImageValue!.path,
                        filename: 'existing_image.jpg',
                      ),
                      'existing_solution_video': await MultipartFile.fromFile(
                        allBlocksData.existingVideoValue!.path,
                        filename: 'existing_video.jpg',
                      ),
                      'proposed_solution_text': allBlocksData.proposedTextValue,
                      'proposed_solution_image': await MultipartFile.fromFile(
                        allBlocksData.proposedImageValue!.path,
                        filename: 'proposed_image.jpg',
                      ),
                      'proposed_solution_video': await MultipartFile.fromFile(
                        allBlocksData.proposedVideoValue!.path,
                        filename: 'proposed_video.jpg',
                      ),
                      'positive_effect': allBlocksData.positiveEffectValue,
                    });
                    final dataToSend = Map<String, dynamic>.fromEntries(
                      formData.fields.map((e) => MapEntry(e.key, e.value)),
                    );

                    phoneNumberCheker.sendData(dataToSend);
                  }
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => widget.next));
                },
                child: Text(
                  widget.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
