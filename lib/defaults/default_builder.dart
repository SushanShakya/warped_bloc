import 'package:warped_bloc/config/default_builder_config.dart';
import 'package:flutter/material.dart';

import '../states/state.dart';

/// T = Type of state of Bloc in use
/// D = Type of Data expected when you get Data
/// E = Type of Data expected in Error
Widget Function(BuildContext, BlocState)
    defaultBuilder<D extends DataState, E>({
  Widget Function(BuildContext context)? onLoading,
  required Widget Function(BuildContext context, D state) onData,
  Widget Function(BuildContext context, ErrorState<E> state)? onError,
  Widget Function(BuildContext context)? otherwise,
}) =>
        (context, state) {
          if (state is LoadingState) {
            return (onLoading != null)
                ? onLoading(context)
                : DefaultBuilderConfig.onLoading(context);
          }
          if (state is D) {
            return onData(context, state);
          }
          if (state is ErrorState<E>) {
            return (onError != null)
                ? onError(context, state)
                : DefaultBuilderConfig.onError(context, state);
          }
          return (otherwise != null) ? otherwise(context) : Container();
        };
