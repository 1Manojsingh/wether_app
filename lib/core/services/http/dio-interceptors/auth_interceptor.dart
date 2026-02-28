// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../config/config.dart';
// import '../../../router/app_router.dart';

// final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
//   return AuthInterceptor(ref);
// });

// class AuthInterceptor implements Interceptor {
//   AuthInterceptor(this.ref);

//   final Ref ref;

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     if (err.response!.statusCode! == 401) {
//       ref.read(prefsProvider).clear().then((value) {
//         ref.read(routerProvider).replaceAll([const SignInRoute()]);
//       });
//     }

//     handler.next(err);
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print("OPTIONS:::::::: ${options}");
//     final token = ref.read(prefsProvider).get(PrefKeys.accessToken);

//     if (options.path.contains('/search')) {
//       options = options.copyWith(baseUrl: Configs.sseSearchBaseUrl);
//     } else if (options.path == '/server_events') {
//       options = options.copyWith(baseUrl: Configs.sseBaseUrl);
//     }

//     return handler.next(options.copyWith(
//         headers: options.headers..addAll({"Authorization": "Bearer $token"})));
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     handler.next(response);
//   }
// }
