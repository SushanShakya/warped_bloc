import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _WrapperType { listenerOnly, builderOnly, consumer, none }

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

  _WrapperType get type {
    if (listener != null && builder != null) {
      return _WrapperType.consumer;
    }
    if (listener != null) {
      return _WrapperType.listenerOnly;
    }
    if (builder != null) {
      return _WrapperType.builderOnly;
    }
    return _WrapperType.none;
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case _WrapperType.builderOnly:
        return BlocBuilder<E, T>(
          bloc: bloc,
          builder: builder!,
        );
      case _WrapperType.listenerOnly:
        return BlocListener<E, T>(
          bloc: bloc,
          listener: listener!,
          child: child!,
        );
      case _WrapperType.consumer:
        return BlocConsumer<E, T>(
          bloc: bloc,
          builder: builder!,
          listener: listener!,
        );
      case _WrapperType.none:
        return const Scaffold();
    }
  }
}
