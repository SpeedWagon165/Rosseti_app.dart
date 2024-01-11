import 'dart:io';

import 'package:dio/dio.dart';

class AllBlocksData {
  final String titleValue;
  final int topicValue;
  final String existingTextValue;
  final File? existingImageValue;
  final File? existingVideoValue;
  final String proposedTextValue;
  final File? proposedImageValue;
  final File? proposedVideoValue;
  final String positiveEffectValue;

  AllBlocksData({
    required this.titleValue,
    required this.topicValue,
    required this.existingTextValue,
    required this.existingImageValue,
    required this.existingVideoValue,
    required this.proposedTextValue,
    required this.proposedImageValue,
    required this.proposedVideoValue,
    required this.positiveEffectValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': titleValue,
      'existing_solution_text': existingTextValue,
      'existing_solution_image': existingImageValue,
      'existing_solution_video': existingVideoValue,
      'proposed_solution_text': proposedTextValue,
      'proposed_solution_image': proposedImageValue,
      'proposed_solution_video': proposedVideoValue,
      'positive_effect': positiveEffectValue,
    };
  }
}

class FormDataHelper {
  static Future<FormData> createFormData(AllBlocksData data) async {
    return FormData.fromMap({
      'title': data.titleValue,
      'topic_id': data.topicValue.toString(),
      'existing_solution_text': data.existingTextValue,
      'existing_solution_image': data.existingImageValue != null
          ? await MultipartFile.fromFile(data.existingImageValue!.path,
              filename: 'existing_image.jpg')
          : null,
      'existing_solution_video': data.existingVideoValue != null
          ? await MultipartFile.fromFile(data.existingVideoValue!.path,
              filename: 'existing_video.mp4')
          : null,
      'proposed_solution_text': data.proposedTextValue,
      'proposed_solution_image': data.proposedImageValue != null
          ? await MultipartFile.fromFile(data.proposedImageValue!.path,
              filename: 'proposed_image.jpg')
          : null,
      'proposed_solution_video': data.proposedVideoValue != null
          ? await MultipartFile.fromFile(data.proposedVideoValue!.path,
              filename: 'proposed_video.mp4')
          : null,
      'positive_effect': data.positiveEffectValue,
    });
  }
}
