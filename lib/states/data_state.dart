part of 'state.dart';

/// Extend this state when you want any type of data
abstract class DataState<T> extends BlocState {
  final T data;
  const DataState({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
