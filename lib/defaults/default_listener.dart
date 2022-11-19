import 'package:warped_bloc/config/default_listener_config.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

/// T = Type of state of Bloc in use
/// D = Type of Data expected when you get Data
/// E = Type of Data expected in Error
void Function(BuildContext, T) defaultListener<T, D, E>({
  void Function(BuildContext context)? onLoading,
  void Function(BuildContext context, D data)? onData,
  void Function(BuildContext context, ErrorState<E> state)? onError,
  void Function(BuildContext context)? onStateChange,
}) =>
    (context, T state) {
      if (state is LoadingState) {
        return (onLoading != null)
            ? onLoading(context)
            : DefaultListenerConfig.onLoading(context);
      }
      (onStateChange != null)
          ? onStateChange(context)
          : DefaultListenerConfig.onStateChange(context);
      if (state is DataState<D>) {
        return (onData != null)
            ? onData(context, state.data)
            : DefaultListenerConfig.onData<D>(context, state.data);
      }
      if (state is ErrorState<E>) {
        return (onError != null)
            ? onError(context, state)
            : DefaultListenerConfig.onError<E>(context, state);
      }
    };
