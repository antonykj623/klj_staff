import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {
    on<IncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
