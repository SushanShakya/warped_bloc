import 'package:bloc_utils/bloc_utils.dart';

class HomeLoaded extends DataState<List<String>> {
  const HomeLoaded(List<String> data) : super(data: data);
}

class HomeCubit extends AsyncCubit {
  fetch() {
    // This Function Takes care of Loading and Error State
    handleDefaultStates(() async {
      await Future.delayed(const Duration(seconds: 2));
      emit(const HomeLoaded(['Sushan', 'Suraj', 'Sakshyam']));
    });
  }
}
