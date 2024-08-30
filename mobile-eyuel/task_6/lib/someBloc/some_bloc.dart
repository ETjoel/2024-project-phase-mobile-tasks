import 'package:bloc/bloc.dart';

class CounterState {
  final int value;
  CounterState(this.value);
}

class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterState(state.value + 1));
    });
  }
}
