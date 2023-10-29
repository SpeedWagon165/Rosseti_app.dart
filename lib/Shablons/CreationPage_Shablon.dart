import 'dart:io';
import 'package:rosseti_project/Video_player_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosseti_project/profile.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreationShablon extends StatefulWidget {
  CreationShablon({
    Key? key,
    required this.text,
    required this.textLow,
    required this.next,
    required this.isConditionMet,
    required this.buttonText,
  }) : super(key: key);
  final String text;
  final String buttonText;
  final String textLow;
  final dynamic next;
  final bool isConditionMet;

  @override
  State<CreationShablon> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreationShablon> {
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
    videoPath = video.path; // Инициализируем videoPath
    setState(() => this.video = video);
    return getVideoThumbnail(videoPath);
  }

  Future<Uint8List?> getVideoThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath, // Используем videoPath
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
            SizedBox(height: 68),
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Status()),
                        );
                      },
                      child: Image.asset('assets/sharos.png'),
                    ),
                  ],
                ),
                Center(
                  child: Text(widget.textLow,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Container(
                  height: 292.0,
                  child: Material(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: const TextField(
                      minLines: 20,
                      maxLines: null,
                      decoration: InputDecoration(
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
                        : SizedBox(),
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

                              return Container(
                                width: 91,
                                height: 51,
                                child: const Text(
                                    'Ошибка загрузки'), // Просто серый фон, можно заменить на свою заглушку
                              );
                            },
                          )
                        : SizedBox(),
                    if (widget.isConditionMet)
                      Container(
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
                      Container(
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
                onPressed: () {
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
