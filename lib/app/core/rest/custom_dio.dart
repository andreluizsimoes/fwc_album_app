import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:fwc_album_app/app/core/rest/interceptors/auth_interceptor.dart';

import '../config/env/env.dart';

class CustomDio extends DioForNative {
  final _authInterceptor = AuthInterceptor();

  CustomDio()
      : super(BaseOptions(
            baseUrl: Env.i['backend_base_url'] ?? '',
            connectTimeout: 5000,
            receiveTimeout: 60000)) {
    interceptors.add(LogInterceptor(
        requestBody: true, responseBody: true, requestHeader: true));
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    interceptors.add(LogInterceptor(
        requestBody: true, responseBody: true, requestHeader: true));
    return this;
  }

  CustomDio unAuth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
