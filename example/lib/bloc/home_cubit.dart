import 'package:warped_bloc/warped_bloc.dart';

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
