part of 'send_messege_bloc.dart';

@immutable
abstract class SendMessegeState {}

class SendMessegeInitial extends SendMessegeState {}

abstract class GlobalState {}

class GlobalInitial extends GlobalState {
  final String initialValue;

  GlobalInitial(this.initialValue);
}
