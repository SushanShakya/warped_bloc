// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_utils/widgets/error_widget.dart';
import 'package:bloc_utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

class DefaultBuilderConfig {
  static Widget Function()? _onLoading;
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
