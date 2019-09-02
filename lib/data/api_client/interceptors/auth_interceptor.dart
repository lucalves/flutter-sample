import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    final di = await AppDi.create();
    final permission = await di.authRepository.getPermission();
    if (permission.isAuthenticated) {
      final authToken = await di.authRepository.getToken();
      options.headers['Authorization'] = 'JWT ${authToken.token}';
    }
    return options;
  }

  @override
  onError(DioError error) {
    return null;
  }
}