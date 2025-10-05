import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum WrapperType { listenerOnly, builderOnly, consumer, none }

/// [Widget] to automatically switch between [BlocBuilder], [BlocListener] and [BlocConsumer]
@Deprecated("Use BlocBuilder or BlocListener instead")
class BlocWrapper<E extends BlocBase<T>, T> extends StatelessWidget {
  final void Function(BuildContext context, T state)? listener;
  final Widget Function(BuildContext context, T state)? builder;
  final Widget? child;
  final E? bloc;

  const BlocWrapper({
    Key? key,
    this.listener,
    this.builder,
    this.bloc,
    this.child,
  })  : assert((builder != null) ||
            (listener != null && child != null) ||
            (listener != null && builder != null)),
        super(key: key);

  WrapperType get type {
    if (listener != null && builder != null) {
      return WrapperType.consumer;
    }
    if (listener != null) {
      return WrapperType.listenerOnly;
    }
    if (builder != null) {
      return WrapperType.builderOnly;
    }
    return WrapperType.none;
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WrapperType.builderOnly:
        return BlocBuilder<E, T>(
          bloc: bloc,
          builder: builder!,
        );
      case WrapperType.listenerOnly:
        return BlocListener<E, T>(
          bloc: bloc,
          listener: listener!,
          child: child!,
        );
      case WrapperType.consumer:
        return BlocConsumer<E, T>(
          bloc: bloc,
          builder: builder!,
          listener: listener!,
        );
      case WrapperType.none:
        return const Scaffold();
    }
  }
}
