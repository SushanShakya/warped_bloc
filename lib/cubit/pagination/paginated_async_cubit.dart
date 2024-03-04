import 'package:warped_bloc/warped_bloc.dart';

import 'pagination_param.dart';

/// A cubit designed specifically for handling paginated
/// data.
///
/// Usage Example :
///
/// class ArtistCubit extends PaginatedAsyncCubit<Artist> {
///   final ArtistRepo repo;

///   ArtistCubit({required this.repo});

///   void fetch() async {
///     handleDefaultStates(() async {
///       final data = await paginatedFetch(() => repo.fetchData());
///       emit(ArtistLoaded(data: data));
///     });
///   }
///
///   @override
///   void onFetchMore() {
///     if (!hasNext) return;
///     fetch();
///   }
/// }
///
abstract class PaginatedAsyncCubit<T> extends AsyncCubit {
  /// Define the page variable to keep track of curent page
  int page = 1;

  /// Define how many items should be fetched per page
  int perPage = 15;

  /// Defines if there is more data remaining to be fetched
  bool hasNext = true;

  /// A variable to store a cache copy in which in the paginated
  /// data will be added to
  List<T> cached = [];

  /// The parameter to be sent to the REST API when calling the API
  PaginationParam get param => PaginationParam(page: page, perPage: perPage);

  /// [showLoading] is defined to check if we should show loading or not
  /// when performing API call. We'll only show loading if we're fetching
  /// the 1st page.
  bool get showLoading => page == 1;

  /// Computes if there is data remaining to be fetched
  /// The Logic is that if we set [perPage] as 15 and we get
  /// 15 data from the API then more data may exist
  bool computeNextExists(List<T> data) {
    return data.length == perPage;
  }

  /// A wrapper function which is used to perform pagination
  /// related API calls.
  Future<List<T>> paginatedFetch(Future<List<T>> Function() fn) async {
    final data = await fn();
    final nextExists = computeNextExists(data);
    hasNext = nextExists;
    page++;
    cached.addAll(data);
    return [...cached];
  }

  /// Function that will be called when user scrolls to
  /// the end of the list when using [PaginatedBuilder]
  void onFetchMore();

  /// To Reset the Paginated Async Cubit
  void reset() {
    page = 1;
    hasNext = true;
    cached = [];
  }

  /// For [PaginatedAsyncCubit] we use the showLoading defined
  /// the current class so that it will only load when page is not 1
  @override
  void handleDefaultStates(
    Future<void> Function() executor, {
    bool? showLoading,
    String? defaultErrorMessage,
  }) =>
      super.handleDefaultStates(
        executor,
        showLoading: showLoading ?? this.showLoading,
        defaultErrorMessage: defaultErrorMessage,
      );
}
