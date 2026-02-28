import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../exceptions/failure.dart';
import '../../model/server_response.dart';

abstract class HttpService {
  String get baseUrl;

  Map<String, String> get headers;

  Future<Either<Failure, ServerResponse>> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });

  Future<Either<Failure, ResponseBody>> streamGet(
    String url, {
    Map<String, dynamic>? headers,

    ///For dio only
    CancelToken? cancelToken,
  });

  Future<Either<Failure, ServerResponse>> post({
    required String url,
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, ServerResponse>> patch({
    required String url,
    Object? data,
    Map<String, dynamic>? headers,
  });

  Future<Either<Failure, ServerResponse>> put({
    required String url,
    Object? data,
    Map<String, dynamic>? headers,
  });

  Future<Either<Failure, ServerResponse>> delete(
    String url, {
    Object? body,
    Map<String, dynamic>? headers,
  });
}
