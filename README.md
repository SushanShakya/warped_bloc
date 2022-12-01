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
<img src="./assets/warped_bloc.png" alt="Bloc" />
</p>

<br>

[Read Proper Documentation on Medium](https://medium.com/@sushaanshakya88/using-warped-bloc-to-reduce-boilerplate-code-when-using-bloc-pattern-flutter-d5adf4d4f47d)

Normally, when we use "bloc" as a state management solution we use it to fetch some data.

The Logic for GET request and POST request is quite similar.
All you want are :
1. LOADING STATE
2. DATA STATE (Where you get data from GET request or success|fail for POST request)
3. ERROR STATE (In case some error occurs)

The point is, we end up repeating these states all over the place if we want to create
and app with BLoC pattern. Packages like 'freezed' try to help but the code generation
is just too boring.

So, this package is a solution to that problem.

## Features

1. Introducing `AsyncCubit` to deal with all of your API related states easily.

    It is pre-baked with `INITIAL`, `LOADING`, `FAILED` states so you don't have to declare then again and again and again.

    To use it :
    ```
    // DataState<T>() is from this package
    class MyBlocState extends DataState<List<Data>> {
        MyBlocState(List<Data> data) : super(data: data);
    }

    class MyBloc extends AsyncCubit {
        fetch() {
            // LoadingState() is from this package
            emit(LoadingState());
            try{
                var data = await someApiCall();
                emit(MyBlocState(data));
            }catch(e) {
                // ErrorState() is from this package
                emit(ErrorState(message: e.toString()));
            }
        }
    }
    ```

2. `BlocWrapper` to finally get rid of having to remember when to use `BlocListener`, `BlocBuilder` or `BlocConsumer`.
<br>
<br>
    If you give it a `builder` as : 
    ```
    BlocWrapper(
        builder: (context, state) => SomeWidget(),
    )
    ```
    then, it behaves as `BlocBuilder`.

    <br>

    If you give it a `listener` with `child` as : 
    ```
    BlocWrapper(
        listener: (context, state) {...}, 
        child: SomeWidget(),
    ),
    ```
    then, it behaves as `BlocListener`.

    <br>

    If you give it `builder` and `listener` and `child` as :
    ```
    BlocWrapper(
        listener: (context, state) {...},
        builder: (context, state) => SomeWidget(),
        child: SomeOtherWidget(),
    )
    ```
    then, it behaves as `BlocConsumer` and `ignores` "child" parameter.

<br><br>

3. No need to use `if else` when dealing with `AsyncCubit` states. <br>
   
   For `builder` parameter, use `defaultBuilder` as :
   ```
   BlocWrapper<MyBloc, BlocState>(
        builder: defaultBuilder<BlocState, List<Data>, String>(
            onLoading: () => LoadingWidget(),
            onData: (List<Data> data) => ListingWidget(data),
            onError: (state) => ErrorWidget(state.message),
        )
   )
   ```

   For `listener` paramter, use `defaultListener` as :
   ```
   BlocWrapper<MyBloc, BlocState>(
        listener: defaultListener<BlocState, List<Data>, String>(
            onLoading: (context) {...},
            onData: (context, List<Data> data) {...},
            onError: (context, state) {...},
        ),
        child: ...,
   ) 
   ```


## Getting started

Add this package to your pubspec.yaml to start using it right now.

## Usage

More Usage detail in example.

## Additional information

Will be releasing blog on using this package soon.
