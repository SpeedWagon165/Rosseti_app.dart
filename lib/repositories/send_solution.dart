import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

class SendSolution {
  PhoneNumberCheker dio = PhoneNumberCheker();

  final titleProvider = 'Biba';
  final existingTextProvider = '';
  final existingImageProvider = StateProvider<File?>((ref) => File(''));
  final existingVideoProvider = StateProvider<File?>((ref) => File(''));
  final proposedTextProvider = StateProvider<String?>((ref) => '');
  final proposedImageProvider = StateProvider<File?>((ref) => File(''));
  final proposedVideoProvider = StateProvider<File?>((ref) => File(''));
  final positiveEffectProvider = StateProvider<String?>((ref) => '');

  Map<String, dynamic> toJson() {
    return {
      'title': titleProvider,
      'existing_solution_text': existingTextProvider,
      'existing_solution_image': existingImageProvider,
      'existing_solution_video': existingVideoProvider,
      'proposed_solution_text': proposedTextProvider,
      'proposed_solution_image': proposedImageProvider,
      'proposed_solution_video': proposedVideoProvider,
      'positive_effect': positiveEffectProvider,
    };
  }
}
