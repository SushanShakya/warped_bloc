import 'package:warped_bloc/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import '../states/state.dart';

/// This configuration will be used by the [defaultListener()]
/// To determine what to build when there is
/// [Loading State] [State Changes] [Data State] [Error State]
/// Default Behaviour is that it will show a [Loading Dialog] and then
/// when the [state changes] it will stop showing loading and then show
/// [Success Snackbar] or [Error Snackbar] based on [Data State] or [Error State]
class DefaultListenerConfig {
  static void Function(BuildContext context)? _onLoading;
  static void Function<D>(BuildContext context, D data)? _onData;
  static void Function<E>(BuildContext context, ErrorState<E> state)? _onError;
  static void Function(BuildContext context)? _onStateChange;

  static void Function(BuildContext context) get onLoading =>
      _onLoading ??
      (context) {
        showLoadingDialog(context);
      };

  static void Function<D>(BuildContext context, D data) get onData =>
      _onData ??
      <D>(context, data) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Success',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      };
  static void Function<E>(BuildContext context, ErrorState<E> state)
      get onError =>
          _onError ??
          <E>(context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          };
  static void Function(BuildContext context) get onStateChange =>
      _onStateChange ??
      (context) {
        Navigator.of(context).pop();
      };

  /// Use this function inside [main] to configure [defaultListener]
  /// [to do Nothing] when the state changes
  static void configureToDoNothing() {
    _onLoading = (c) {};
    _onData = <D>(c, d) {};
    _onError = <E>(c, state) {};
    _onStateChange = (c) {};
  }

  /// Use this function inside [main] to configure [defaultListener]
  /// To perform certain task for each state.
  static void configure({
    required void Function(BuildContext context)? onLoading,
    required void Function<D>(BuildContext context, D state)? onData,
    required void Function<E>(BuildContext context, ErrorState<E> state)?
        onError,
    void Function(BuildContext context)? onStateChange,
  }) {
    if (onLoading != null) {
      _onLoading = onLoading;
    }
    if (onData != null) {
      _onData = onData;
    }
    if (onStateChange != null) {
      _onStateChange = onStateChange;
    }
    if (onError != null) {
      _onError = onError;
    }
  }
}
