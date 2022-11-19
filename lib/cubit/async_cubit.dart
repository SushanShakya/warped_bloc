import 'package:warped_bloc/warped_bloc.dart';

class AsyncCubit extends Cubit<BlocState> {
  AsyncCubit({
    BlocState? initialState,
  }) : super(initialState ?? InitialState());

  void handleDefaultStates(Future<void> Function() executor) async {
    emit(LoadingState());
    try {
      await executor();
    } on Failure catch (e) {
      emit(ErrorState(message: e.message));
    }
  }
}
