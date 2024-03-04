<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

<p align="center">
<img src="https://raw.githubusercontent.com/SushanShakya/warped_bloc/main/assets/warped_bloc.png" alt="Bloc" />
</p>

<br>

[Read Documentation on Medium](https://medium.com/@sushaanshakya88/reduce-boilerplate-code-by-using-warped-bloc-in-flutter-9ae76c2d1f1b)

## Introduction
`[warped_bloc]` is a package which I came up with to remove boilerplate code when using BLoC pattern in Flutter. It is built on top of `[flutter_bloc]` which is a package by Felix Angelov. `[warped_bloc]` is specifically for reducing boilerplate code for API calls.

## Idea
The idea for boilerplate reduction is that whenever we use a state management solution like BLoC to handle API calls it has 3 particular state associated with it :

1. `Loading State` (When the request is processing)
2. `Data State` (When the request is success and it returns some data)
3. `Error State` (In case any error has occurred)

We end up writing these states again and again and handling these state either via if statements or by using `.when()` if using sealed classes.

Since this is common for all API calls we should be able to generalize it.

And Hence, `[warped_bloc]` was born.

## How to use ?

`[warped_bloc]` comes with prebaked states :

1. `InitialState` class
2. `LoadingState` class
3. `ErrorState<T>` class
4. `DataState<T>` class

It also comes with utils to help with BlocListener and BlocBuilder :

1. `defaultBuilder` function
2. `defaultListener` function

It provides bases clases that can be extended :

1. `AsyncCubit` class
2. `PaginatedAsyncCubit` class

Consider the following scenario of API call :

## Get Request

```
import 'package:example/repo/home_repo.dart';
import 'package:warped_bloc/warped_bloc.dart';

class HomeLoaded extends DataState<List<String>> {
  const HomeLoaded(List<String> data) : super(data: data);
}

class HomeCubit extends AsyncCubit {
  final HomeRepo repo;

  HomeCubit({
    required this.repo,
  });

  fetch() {
    // This Function Takes care of Loading and Error State
    handleDefaultStates(() async {
      final data = await repo.fetch();
      emit(HomeLoaded(data));
    });
  }
}
```

```
class HomeRepo {
  final Dio dio;

  Future<List<String>> fetch() async {
    final res = await dio.get('/data');
    return List<String>.from(res.data);
  }
}
```

Now, we can simply handle the UI as follows :

```
BlocBuilder<HomeCubit, BlocState>(
  bloc: cubit,

  // defaultBuilder() handles showing loading and error states
  builder: defaultBuilder<HomeLoaded, void>(
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
);
```

Notice that we’ve used defaultBuilder which is provided by `[warped_bloc]` package. It takes 2 generics `defaultBuilder<T, E>` . `T` refers to the type of data state emitted by the cubit, `E` is the type of the data variable in ErrorState . We can ignore `E` and always use void as it’s data type.

## Post Request

```
import 'package:warped_bloc/warped_bloc.dart';

class HomeActionSuccess extends DataState<void> {
  const HomeActionSuccess() : super(data: null);
}

class HomeActionCubit extends AsyncCubit {
  final HomeRepo repo;

  HomeActionCubit({required this.repo});

  updateProfile(ProfileRequest request) {
    handleDefaultStates(() async {
      await repo.updateProfile(profile);
      emit(const HomeActionSuccess());
    });
  }
}
```

```
class HomeRepo {
  final Dio dio;

  Future<List<String>> updateProfile(ProfileRequest request) async {
    final res = await dio.post('/profile', data: request.toMap());
    return List<String>.from(res.data);
  }
}
```

Now, we can simply handle the UI as follows :

```
final actionCubit = HomeActionCubit(repo: HomeRepo(dio: Dio()));
...
BlocListener<HomeActionCubit, BlocState>(
  listener: defaultListener<HomeActionSuccess, void>(),
  child: FloatingActionButton(
    onPressed: () {
      // actionCubit.someAction();
      actionCubit.someFailedAction();
    },
    child: const Icon(Icons.add),
  ),
);
...
```

Notice that we’ve used `defaultListener` which is provided by `[warped_bloc]` package. It takes 2 generics `defaultListener<T, E>` . `T` refers to the type of data state emitted by the cubit, `E` is the type of the data variable in `ErrorState` . We can ignore `E` and always use void as it’s data type. Notice that we don’t need to pass anything inside defaultListener it handles Loading, Error and Data state itself. We can customize this behavior by passing in parameters.

## Handling Pagination

```
import 'package:example/repo/home_repo.dart';
import 'package:warped_bloc/warped_bloc.dart';

class PaginatedHomeLoaded extends DataState<List<String>> {
  const PaginatedHomeLoaded({required List<String> data}) : super(data: data);
}

class PaginatedHomeCubit extends PaginatedAsyncCubit<String> {
  final HomeRepo repo;
  PaginatedHomeCubit({
    required this.repo,
  });

  void fetch() {
    handleDefaultStates(() async {
      final data = await paginatedFetch(() => repo.fetch(param: param));
      emit(PaginatedHomeLoaded(data: data));
    });
  }

  @override
  void onFetchMore() {
    print('--- Fetch More');
    if (!hasNext) return;
    fetch();
  }
}
```

```
class HomeRepo {
  final Dio dio;

  Future<List<String>> fetch({PaginationParam param}) async {
    final res = await dio.get('/paginatedData', data: param.toMap() );
    return List<String>.from(res.data);
  }
}
```

```
class PaginationParam {
  final int page;
  final int perPage;

  PaginationParam({
    required this.page,
    required this.perPage,
  });

  Map<String, dynamic> toMap() {
    return {
      "page": page,
      "per_page": perPage,
    };
  }
}
```

Then, we can handle it in UI as :

```
...
BlocBuilder<PaginatedHomeCubit, BlocState>(
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
)
...
```

This is just the tip of the iceberg on the things we can do with [warped_bloc] package.