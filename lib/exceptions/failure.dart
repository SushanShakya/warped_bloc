// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// The type of exception that occurs by default
/// inside a function in [AsyncCubit]
abstract class Failure<T> extends Equatable {
  final String message;
  final T? data;

  const Failure(this.message, {this.data});

  @override
  List<Object?> get props => [message, data];
}
