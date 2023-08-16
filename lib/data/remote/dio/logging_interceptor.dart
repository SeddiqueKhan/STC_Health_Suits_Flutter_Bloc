import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    // Customize the printer
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath =
        '${options.baseUrl}${options.path}${options.queryParameters}';

    logger.e('${options.method} request => $requestPath',
        {options.data}); // Debug log
    logger.d(
      'Error: ${err.error}, Message: ${err.response?.data}',
    ); // Error log
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath =
        '${options.baseUrl}${options.path}${options.queryParameters}';
    logger.i('${options.method} request => $requestPath',
        {options.data}); // Info log
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
        'StatusCode: ${response.statusCode}, Data: ${response.data}  , Error: ${response.toString()}'); // Debug log
    return super.onResponse(response, handler);
  }
}