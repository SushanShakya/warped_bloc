part of 'state.dart';

/// Default ErrorState
/// You can extend this class if you want extra data
/// whenever there is an error
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
