import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosseti_project/repositories/send_solution.dart';

SendSolution solution = SendSolution();

class BlocMorph extends Bloc<EventMorphString, String> {
  BlocMorph() : super(solution.titleProvider) {
    on<EventMorphString>(_onChange);
  }

  _onChange(EventMorphString event, Emitter<String> emit) {
    emit(state);
  }
}

class EventMorphString {}
