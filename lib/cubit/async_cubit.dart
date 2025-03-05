import 'dart:async';
import 'dart:developer';

import 'package:warped_bloc/config/default_error_config.dart';
import 'package:warped_bloc/warped_bloc.dart';

/// This cubit is a wrap around for easily dealing with
/// Async activity.
class AsyncCubit extends Cubit<BlocState> {
  AsyncCubit({
    BlocState? initialState,
  }) : super(initialState ?? InitialState());

  /// Use this function to handle [Loading State] and [Error State] automatically
  void handleDefaultStates(
    Future<void> Function() executor, {
    bool? showLoading,
    String? defaultErrorMessage,
  }) async {
    if (showLoading ?? true) {
      emit(LoadingState());
    }
    try {
      await executor();
    } on Failure catch (e) {
      emit(ErrorState(message: e.message, data: e.data));
    } catch (e) {
      final message = await DefaultErrorConfig.onErrorCaught(e);
      log(e.toString());
      emit(
        ErrorState(
          message:
              message ?? ((defaultErrorMessage) ?? "Unknown Error has occured"),
        ),
      );
    }
  }
}
