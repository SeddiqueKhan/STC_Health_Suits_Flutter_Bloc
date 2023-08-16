import 'package:dio/dio.dart';
import 'logging_interceptor.dart';

class DioFactory {
  final String _baseUrl;
  DioFactory(this._baseUrl);

  BaseOptions _createBaseOptions() => BaseOptions(
      baseUrl: _baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 6), // 60 seconds
      receiveTimeout: const Duration(seconds: 6) // 60 seconds
      );

  Dio create() => Dio(_createBaseOptions())
    ..interceptors.addAll([
      LoggerInterceptor(),
    ]);
}
