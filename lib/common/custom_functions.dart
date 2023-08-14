import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../data/exceptions/ErrorResponse.dart';

ErrorResponse hCheckExceptionType(DioError dioError) {
  ErrorResponse error;
  switch (dioError.type) {
    case DioExceptionType.cancel:
      error = ErrorResponse.fromJson(jsonDecode(
          dioError.error.toString())); //'Request to the server was cancelled.';
      break;
    case DioExceptionType.connectionTimeout:
      error = ErrorResponse.fromJson(
          jsonDecode(dioError.error.toString())); //'Connection timed out.';
      break;
    case DioExceptionType.receiveTimeout:
      error = ErrorResponse.fromJson(jsonDecode(
          dioError.error.toString())); //'Receiving timeout occurred.';
      break;
    case DioExceptionType.sendTimeout:
      error = ErrorResponse.fromJson(
          jsonDecode(dioError.error.toString())); //'Request send timeout.';
      break;
    case DioExceptionType.unknown:
      if (dioError.message!.contains('SocketException')) {
        error = ErrorResponse(
            message: 'No Internet Connection.',
            statusCode: 5,
            status: null,
            errors: null,
            info: null); //'No Internet Connection.';
        break;
      }
      error = ErrorResponse.fromJson(jsonDecode(
          dioError.error.toString())); //'Unexpected error occurred.';
      break;
    default:
      error = ErrorResponse.fromJson(jsonDecode(dioError.response.toString()));
      break;
  }

  return error;
}