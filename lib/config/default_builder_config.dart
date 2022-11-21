// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:warped_bloc/widgets/error_widget.dart';
import 'package:warped_bloc/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

/// This configuration will be used by the [defaultBuilder()]
/// To determine what to build when there is a [Loading State] and [Error State]
class DefaultBuilderConfig {
  /// Called by [defaultBuilder] when there is a loading state
  static Widget Function()? _onLoading;

  /// Called by [defaultBuilder] when there is a error state
  static Widget Function<E>(ErrorState<E> state)? _onError;

  static Widget Function() get onLoading {
    return DefaultBuilderConfig._onLoading ??
        () {
          return DefaultLoadingWidget();
        };
  }

  static Widget Function<E>(ErrorState<E> state) get onError {
    return DefaultBuilderConfig._onError ??
        <E>(state) {
          return DefaultErrorWidget(message: state.message);
        };
  }

  /// Call this function inside [main] to configure what [Widget]
  /// to show when there is [Loading State] or [Error State]
  static configure(
      {Widget Function()? onLoading,
      Widget Function<E>(ErrorState<E> state)? onError}) {
    if (onLoading != null) {
      _configureOnLoading(onLoading);
    }
    if (onError != null) {
      _configureOnError(onError);
    }
  }

  static _configureOnLoading(Widget Function()? onLoading) {
    DefaultBuilderConfig._onLoading = onLoading;
  }

  static _configureOnError(Widget Function<E>(ErrorState<E> state) onError) {
    DefaultBuilderConfig._onError = onError;
  }
}
