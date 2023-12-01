part of 'send_messege_bloc.dart';

@immutable
abstract class SendMessegeEvent {}

abstract class GlobalEvent {}

class UpdateGlobalValue extends GlobalEvent {
  final String value;

  UpdateGlobalValue(this.value);
}
