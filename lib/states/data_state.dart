part of 'state.dart';

abstract class DataState<T> extends BlocState {
  final T data;
  const DataState({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
