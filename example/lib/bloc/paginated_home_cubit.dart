// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:example/repo/home_repo.dart';

import 'package:warped_bloc/cubit/pagination/paginated_async_cubit.dart';
import 'package:warped_bloc/states/state.dart';

class PaginatedHomeLoaded extends DataState<List<String>> {
  const PaginatedHomeLoaded({required List<String> data}) : super(data: data);
}

class PaginatedHomeCubit extends PaginatedAsyncCubit<String> {
  final HomeRepo repo;
  PaginatedHomeCubit({
    required this.repo,
  });

  void fetch() {
    handleDefaultStates(() async {
      final data = await paginatedFetch(() => repo.fetch(param: param));
      emit(PaginatedHomeLoaded(data: data));
    });
  }

  @override
  void onFetchMore() {
    print('--- Fetch More');
    if (!hasNext) return;
    fetch();
  }
}
