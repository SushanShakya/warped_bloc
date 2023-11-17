import 'package:warped_bloc/config/default_listener_config.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

/// T = Type of state of Bloc in use
/// D = Type of Data expected when you get Data
/// E = Type of Data expected in Error
void Function(BuildContext, BlocState) defaultListener<D extends DataState, E>({
  void Function(BuildContext context)? onLoading,
  void Function(BuildContext context, D state)? onData,
  void Function(BuildContext context, ErrorState<E> state)? onError,
  void Function(BuildContext context)? onStateChange,
}) =>
    (context, state) {
      if (state is LoadingState) {
        return (onLoading != null)
            ? onLoading(context)
            : DefaultListenerConfig.onLoading(context);
      }
      (onStateChange != null)
          ? onStateChange(context)
          : DefaultListenerConfig.onStateChange(context);
      if (state is D) {
        return (onData != null)
            ? onData(context, state)
            : DefaultListenerConfig.onData(context, state);
      }
      if (state is ErrorState<E>) {
        return (onError != null)
            ? onError(context, state)
            : DefaultListenerConfig.onError(context, state);
      }
    };
