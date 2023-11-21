// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:warped_bloc/widgets/error_widget.dart';
import 'package:warped_bloc/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

/// This configuration will be used by the [defaultBuilder()]
/// To determine what to build when there is a [Loading State] and [Error State]
class DefaultBuilderConfig {
  /// Called by [defaultBuilder] when there is a loading state
  static Widget Function(BuildContext context)? _onLoading;

  /// Called by [defaultBuilder] when there is a error state
  static Widget Function(BuildContext context, ErrorState state)? _onError;

  static Widget Function(BuildContext context) get onLoading {
    return DefaultBuilderConfig._onLoading ??
        (context) {
          return DefaultLoadingWidget();
        };
  }

  static Widget Function(BuildContext context, ErrorState state) get onError {
    return DefaultBuilderConfig._onError ??
        (context, state) {
          return DefaultErrorWidget(message: state.message);
        };
  }

  /// Call this function inside [main] to configure what [Widget]
  /// to show when there is [Loading State] or [Error State]
  static configure({
    Widget Function(BuildContext context)? onLoading,
    Widget Function(BuildContext context, ErrorState state)? onError,
  }) {
    if (onLoading != null) {
      _configureOnLoading(onLoading);
    }
    if (onError != null) {
      _configureOnError(onError);
    }
  }

  static _configureOnLoading(Widget Function(BuildContext context)? onLoading) {
    DefaultBuilderConfig._onLoading = onLoading;
  }

  static _configureOnError(
    Widget Function(BuildContext context, ErrorState state) onError,
  ) {
    DefaultBuilderConfig._onError = onError;
  }
}
