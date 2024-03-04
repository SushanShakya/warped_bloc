// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:example/repo/home_repo.dart';

import 'package:warped_bloc/warped_bloc.dart';

class HomeLoaded extends DataState<List<String>> {
  const HomeLoaded(List<String> data) : super(data: data);
}

class HomeCubit extends AsyncCubit {
  final HomeRepo repo;
  HomeCubit({
    required this.repo,
  });
  fetch() {
    // This Function Takes care of Loading and Error State
    handleDefaultStates(() async {
      final data = await repo.fetch();
      emit(HomeLoaded(data));
    });
  }
}
