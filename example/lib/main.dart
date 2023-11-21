import 'package:warped_bloc/warped_bloc.dart';
import 'package:example/bloc/home_action_cubit.dart';
import 'package:example/bloc/home_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  DefaultBuilderConfig.configure(onLoading: (context) {
    return const Center(
      child: Text("LOADING"),
    );
  }, onError: (context, e) {
    return Column(
      children: [
        const Text("Errrrrrrorrr"),
        Text(e.message),
      ],
    );
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeCubit cubit;
  late HomeActionCubit actionCubit;

  @override
  void initState() {
    super.initState();
    cubit = HomeCubit()..fetch();
    actionCubit = HomeActionCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // actionCubit.someAction();
          actionCubit.someFailedAction();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocWrapper<HomeActionCubit, BlocState>(
        bloc: actionCubit,
        listener: defaultListener(onLoading: (c) {
          showLoadingDialog(context);
        }),
        child: BlocWrapper<HomeCubit, BlocState>(
          bloc: cubit,
          builder: defaultBuilder<HomeLoaded, String>(
            onData: (context, state) {
              final data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (c, i) {
                  var e = data[i];
                  return Text(e);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
