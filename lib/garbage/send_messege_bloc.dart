// import 'dart:io';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// part 'send_messege_event.dart';
//
// part 'send_messege_state.dart';
//
// class TitleBloc extends Bloc<TitleEvents, TitleStates> {
//   TitleBloc() : super(TitleState('Initial Value')) {
//     on<TitleEvent>((event, emit) {
//       emit(TitleState(event.newTitle));
//     });
//   }
// }
//
// class TopicBloc extends Bloc<TitleEvents, TitleStates> {
//   TopicBloc() : super(TopicState(0)) {
//     on<TopicEvent>((event, emit) {
//       emit(TopicState(event.newTopic));
//     });
//   }
// }
//
// class ExistingTextBloc extends Bloc<TitleEvents, TitleStates> {
//   ExistingTextBloc() : super(ExistingTextState('Initial Value')) {
//     on<ExistingTextEvent>((event, emit) {
//       emit(ExistingTextState(event.newExistingText));
//     });
//   }
// }
//
// class ExistingImageBloc extends Bloc<TitleEvents, TitleStates> {
//   ExistingImageBloc() : super(ExistingImageState(File('Initial Value'))) {
//     on<ExistingImageEvent>((event, emit) {
//       emit(ExistingImageState(event.newExistingImage));
//     });
//   }
// }
//
// class ExistingVideoBloc extends Bloc<TitleEvents, TitleStates> {
//   ExistingVideoBloc() : super(ExistingVideoState(File('Initial Value'))) {
//     on<ExistingVideoEvent>((event, emit) {
//       emit(ExistingVideoState(event.newExistingVideo));
//     });
//   }
// }
//
// class ProposedTextBloc extends Bloc<TitleEvents, TitleStates> {
//   ProposedTextBloc() : super(ProposedTextState('Initial Value')) {
//     on<ProposedTextEvent>((event, emit) {
//       emit(ProposedTextState(event.newProposedText));
//     });
//   }
// }
//
// class ProposedImageBloc extends Bloc<TitleEvents, TitleStates> {
//   ProposedImageBloc() : super(ProposedImageState(File('Initial Value'))) {
//     on<ProposedImageEvent>((event, emit) {
//       emit(ProposedImageState(event.newProposedImage));
//     });
//   }
// }
//
// class ProposedVideoBloc extends Bloc<TitleEvents, TitleStates> {
//   ProposedVideoBloc() : super(ProposedVideoState(File('Initial Value'))) {
//     on<ProposedVideoEvent>((event, emit) {
//       emit(ProposedVideoState(event.newProposedVideo));
//     });
//   }
// }
//
// class PositiveEffectBloc extends Bloc<TitleEvents, TitleStates> {
//   PositiveEffectBloc() : super(PositiveEffectState('Initial Value')) {
//     on<PositiveEffectEvent>((event, emit) {
//       emit(PositiveEffectState(event.newPositiveEffect));
//     });
//   }
// }
