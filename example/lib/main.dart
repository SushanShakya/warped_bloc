import 'package:example/bloc/paginated_home_cubit.dart';
import 'package:example/repo/home_repo.dart';
import 'package:warped_bloc/cubit/pagination/paginated_builder.dart';
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
    return const MaterialApp(
      // home: Home(),
      home: PaginatedHome(),
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
    cubit = HomeCubit(repo: HomeRepo())..fetch();
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
      body: BlocListener<HomeActionCubit, BlocState>(
        bloc: actionCubit,
        listener: defaultListener(onLoading: (c) {
          showLoadingDialog(context);
        }),
        child: BlocBuilder<HomeCubit, BlocState>(
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

class PaginatedHome extends StatelessWidget {
  const PaginatedHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaginatedHomeCubit(repo: HomeRepo())..fetch(),
        ),
      ],
      child: _PaginatedHomeBody(),
    );
  }
}

class _PaginatedHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PaginatedHomeCubit, BlocState>(
        builder: defaultBuilder<PaginatedHomeLoaded, void>(
          onData: (context, state) {
            final data = state.data;
            return PaginatedBuilder(
              builder: (c, controller) {
                return ListView.builder(
                  controller: controller,
                  itemCount: data.length,
                  itemBuilder: (c, i) {
                    var e = data[i];
                    return ListTile(
                      title: Text("${i + 1}$e"),
                    );
                  },
                );
              },
              onFetchMore: context.read<PaginatedHomeCubit>().onFetchMore,
            );
          },
        ),
      ),
    );
  }
}
