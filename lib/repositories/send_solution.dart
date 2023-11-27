import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

class SendSolution {
  PhoneNumberCheker dio = PhoneNumberCheker();

  String? title;
  String? existingText;
  File? existingImage;
  File? existingVideo;
  String? proposedText;
  File? proposedImage;
  File? proposedVideo;
  String? positiveEffect;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'existing_solution_text': existingText,
      'existing_solution_image': existingImage,
      'existing_solution_video': existingVideo,
      'proposed_solution_text': proposedText,
      'proposed_solution_image': proposedImage,
      'proposed_solution_video': proposedVideo,
      'positive_effect': positiveEffect,
    };
  }

  void setTitle(String newTitle) {
    title = newTitle;
  }

  void setExistingText(String newTextE) {
    existingText = newTextE;
  }

  void setProposedText(String newTextP) {
    proposedText = newTextP;
  }

  void setPositiveEffect(String newEffect) {
    positiveEffect = newEffect;
  }


  void setExistingImage(File? imageFile) {
    existingImage = imageFile;
  }

  void setExistingVideo(File? videoFile) {
    existingVideo = videoFile;
  }

  void setProposedImage(File? imageFile) {
    proposedImage = imageFile;
  }

  void setProposedVideo(File? videoFile) {
    proposedVideo = videoFile;
  }
}
