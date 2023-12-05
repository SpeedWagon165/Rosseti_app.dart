part of 'send_messege_bloc.dart';

@immutable
abstract class TitleEvents {}

class TitleEvent extends TitleEvents {
  final String newTitle;

  TitleEvent(this.newTitle);
}

class TopicEvent extends TitleEvents {
  final int newTopic;

  TopicEvent(this.newTopic);
}

class ExistingTextEvent extends TitleEvents {
  final String newExistingText;

  ExistingTextEvent(this.newExistingText);
}

class ExistingImageEvent extends TitleEvents {
  final File? newExistingImage;

  ExistingImageEvent(this.newExistingImage);
}

class ExistingVideoEvent extends TitleEvents {
  final File? newExistingVideo;

  ExistingVideoEvent(this.newExistingVideo);
}

class ProposedTextEvent extends TitleEvents {
  final String newProposedText;

  ProposedTextEvent(this.newProposedText);
}

class ProposedImageEvent extends TitleEvents {
  final File? newProposedImage;

  ProposedImageEvent(this.newProposedImage);
}

class ProposedVideoEvent extends TitleEvents {
  final File? newProposedVideo;

  ProposedVideoEvent(this.newProposedVideo);
}

class PositiveEffectEvent extends TitleEvents {
  final String newPositiveEffect;

  PositiveEffectEvent(this.newPositiveEffect);
}
