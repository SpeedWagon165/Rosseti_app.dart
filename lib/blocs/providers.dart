import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/services.dart';

final textProvider = StateProvider<String>((ref) => "");
final selectedTopicIdProvider = StateProvider<int>((ref) => -1);
final existingTextProvider = StateProvider<String>((ref) => '');
final existingImageProvider = StateProvider<File?>((ref) => null);
final existingVideoProvider = StateProvider<File?>((ref) => null);
final videoThumbnailProvider = StateProvider<Uint8List?>((ref) => null);
final proposedTextProvider = StateProvider<String>((ref) => '');
final proposedImageProvider = StateProvider<File?>((ref) => null);
final proposedVideoProvider = StateProvider<File?>((ref) => null);
final positiveEffectTextProvider = StateProvider<String>((ref) => '');
