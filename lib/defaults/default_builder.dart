import 'package:warped_bloc/config/default_builder_config.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

/// T = Type of state of Bloc in use
/// D = Type of Data expected when you get Data
/// E = Type of Data expected in Error
Widget Function(BuildContext, T) defaultBuilder<T, D extends DataState, E>({
  Widget Function()? onLoading,
  required Widget Function(D state) onData,
  Widget Function(ErrorState<E> state)? onError,
  Widget Function()? otherwise,
}) =>
    (context, T state) {
      if (state is LoadingState) {
        return (onLoading != null)
            ? onLoading()
            : DefaultBuilderConfig.onLoading();
      }
      if (state is D) {
        return onData(state.data);
      }
      if (state is ErrorState<E>) {
        return (onError != null)
            ? onError(state)
            : DefaultBuilderConfig.onError<E>(state);
      }
      return (otherwise != null) ? otherwise() : Container();
    };
