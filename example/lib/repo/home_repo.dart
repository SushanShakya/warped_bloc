import 'package:warped_bloc/cubit/pagination/pagination_param.dart';

class HomeRepo {
  Future<List<String>> fetch({PaginationParam? param}) async {
    await Future.delayed(const Duration(seconds: 2));
    // return ['Sushan', 'Suraj', 'Sakshyam'];
    return List.generate(
      15,
      (i) => "Sushan",
    );
  }
}
