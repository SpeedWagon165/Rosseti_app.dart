import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_messege_event.dart';

part 'send_messege_state.dart';

class SendMessegeBloc extends Bloc<SendMessegeEvent, SendMessegeState> {
  SendMessegeBloc() : super(SendMessegeInitial()) {
    on<SendMessegeEvent>((event, emit) {});
  }
}

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalInitial('Initial Value')) {
    on<UpdateGlobalValue>((event, emit) {
      emit(GlobalInitial(event.value));
    });
  }
}
