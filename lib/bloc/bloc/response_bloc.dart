import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'response_event.dart';
part 'response_state.dart';

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  ResponseBloc() : super(ResponseState.initial()) {
    on<ResponseSuccessEvent>(_mapSuccessEventToState);
    on<ResponseErrorEvent>(_mapErrorEventToState);
  }

  Future<void> _mapSuccessEventToState(
      ResponseSuccessEvent event, Emitter<ResponseState> emit) async {
    emit(state.copyWith(sucessful: true));
  }

  Future<void> _mapErrorEventToState(
      ResponseErrorEvent event, Emitter<ResponseState> emit) async {
    emit(state.copyWith(sucessful: false));
  }
}
