// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
//
// final textProvider = StateProvider<String>((ref) => "");
// final selectedTopicIdProvider = StateProvider<int>((ref) => -1);
// final existingTextProvider =
//     StateProvider<TextEditingController>((ref) => TextEditingController());
// final existingImageProvider = StateProvider<File?>((ref) => null);
// final existingVideoProvider = StateProvider<File?>((ref) => null);
// final videoPathProvider = StateProvider<String?>((ref) => null);
// final videoThumbnailProvider = StateProvider<Uint8List?>((ref) => null);
// final proposedTextProvider = StateProvider<String>((ref) => '');
// final proposedImageProvider = StateProvider<File?>((ref) => null);
// final proposedVideoProvider = StateProvider<File?>((ref) => null);
// final positiveEffectTextProvider = StateProvider<String>((ref) => '');
//
// class CreationPageFutures {
//   String? videoPath;
//
//   Future pickImage(WidgetRef ref, ImageSource source) async {
//     try {
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage == null) {
//         print('No image selected.');
//         return;
//       }
//       final imageTemporary = File(pickedImage.path);
//       ref.read(existingImageProvider.notifier).state = imageTemporary;
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<void> pickVideo(WidgetRef ref, ImageSource source) async {
//     try {
//       final pickedVideo = await ImagePicker().pickVideo(source: source);
//       if (pickedVideo == null) {
//         print('No video selected.');
//         return;
//       }
//       final videoFile = File(pickedVideo.path);
//       ref.read(existingVideoProvider.notifier).state = videoFile;
//
//       videoPath = videoFile.path;
//
//       final thumbnail = await getVideoThumbnail(videoPath!);
//       ref.read(videoThumbnailProvider.notifier).state = thumbnail;
//     } on PlatformException catch (e) {
//       print('Failed to pick video: $e');
//     }
//   }
//
//   Future<Uint8List?> getVideoThumbnail(String videoPath) async {
//     final thumbnail = await VideoThumbnail.thumbnailData(
//       video: videoPath,
//       imageFormat: ImageFormat.JPEG,
//       maxWidth: 200,
//       quality: 25,
//     );
//     return thumbnail;
//   }
// }
