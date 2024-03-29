// import 'package:warped_bloc/config/default_builder_config.dart';
// import 'package:warped_bloc/states/state.dart';
// import 'package:warped_bloc/widgets/error_widget.dart';
// import 'package:warped_bloc/widgets/loading_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('DefaultBuilderConfig', () {
//     group('loading', () {
//       test('returns DefaultLoadingWidget when not configured', () {
//         expect(
//           DefaultBuilderConfig.onLoading(),
//           isA<DefaultLoadingWidget>(),
//         );
//       });

//       test('returns User specified Widget when configured', () {
//         DefaultBuilderConfig.configure(onLoading: (context) {
//           return Container();
//         });
//         expect(
//           DefaultBuilderConfig.onLoading(context),
//           isA<Container>(),
//         );
//       });
//     });

//     group('error', () {
//       test('returns DefaultErrorWidget when not configured', () {
//         expect(
//           DefaultBuilderConfig.onError(const ErrorState(message: 'hello')),
//           isA<DefaultErrorWidget>(),
//         );
//       });

//       test('returns User specified Widget when configured', () {
//         DefaultBuilderConfig.configure(onError: <String>(state) {
//           return Container();
//         });

//         expect(
//           DefaultBuilderConfig.onError(const ErrorState(message: 'hello')),
//           isA<Container>(),
//         );
//       });
//     });
//   });
// }
