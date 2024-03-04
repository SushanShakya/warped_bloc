// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaginationParam {
  final int page;
  final int perPage;

  PaginationParam({
    required this.page,
    required this.perPage,
  });

  Map<String, dynamic> toMap() {
    return {
      "page": page,
      "per_page": perPage,
    };
  }
}
