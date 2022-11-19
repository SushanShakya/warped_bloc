part of 'state.dart';

class ErrorState<T> extends BlocState {
  final String message;
  final T? data;

  const ErrorState({
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [message, data];
}
