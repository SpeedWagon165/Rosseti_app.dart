import 'dart:io';

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
