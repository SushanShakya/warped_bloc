import 'package:bloc_utils/bloc_utils.dart';

class HomeActionSuccess extends DataState<void> {
  const HomeActionSuccess() : super(data: null);
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Server Failure');
}

class HomeActionCubit extends AsyncCubit {
  someAction() {
    handleDefaultStates(() async {
      await Future.delayed(const Duration(seconds: 2));
      emit(const HomeActionSuccess());
    });
  }

  someFailedAction() {
    handleDefaultStates(() async {
      await Future.delayed(const Duration(seconds: 2));
      throw const ServerFailure();
    });
  }
}
