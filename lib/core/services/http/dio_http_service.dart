import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../extensions/list_extension.dart';

import '../../config/config.dart';
import '../../exceptions/failure.dart';
import '../../model/server_response.dart';
import 'http_service.dart';

class DioHttpService implements HttpService {
  late final Dio apiClient;
  final Ref ref;

  DioHttpService(this.ref) {
    initialize();
  }

  @override
  String get baseUrl => Configs.weatherBaseUrl;

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  BaseOptions get baseOptions =>
      BaseOptions(baseUrl: baseUrl, headers: headers);

  Failure handleError(dynamic data) {
    if (data is Map) {
      // WeatherAPI error format: { "error": { "code": 1006, "message": "No matching location found." } }
      if (data['error'] is Map) {
        final err = data['error'] as Map;
        final message = err['message']?.toString();
        final code = err['code'] is int ? err['code'] as int : null;
        return Failure(400, code, message ?? 'Something went wrong');
      }

      // Generic API error format: { "detail": "..." } or { "detail": [ { "msg": "..." }, ... ] }
      if (data['detail'] is String) {
        return Failure(1, 1, data['detail'] as String);
      }

      if (data['detail'] is List) {
        final err = (data['detail'] as List).firstOrNull;
        if (err != null) {
          return Failure(1, 1, err['msg']?.toString());
        }
      }
    }
    return const Failure(1, 1, "Something went wrong");
  }

  void initialize() {
    apiClient = Dio(baseOptions);

    if (kDebugMode) {
      apiClient.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ));
    }
    // No auth interceptor needed - WeatherAPI uses API key in query params
  }

  @override
  Future<Either<Failure, ServerResponse>> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await apiClient.get(url,
          queryParameters: queryParams, options: Options(headers: headers));
      return Right(ServerResponse(
          status: true,
          data: response.data,
          responseHeaders: response.headers));
    } on DioException catch (error) {
      return Left(handleError(error.response?.data));
    } catch (error) {
      return Left(handleError(error));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> post({
    required String url,
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await apiClient.post(url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return Right(ServerResponse(
          status: true,
          data: response.data,
          responseHeaders: response.headers));
    } on DioException catch (error) {
      return Left(handleError(error.response?.data));
    } catch (error) {
      return Left(handleError(error));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> patch({
    required String url,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await apiClient.patch(url,
          data: data, options: Options(headers: headers));
      return Right(ServerResponse(
          status: true,
          data: response.data,
          responseHeaders: response.headers));
    } on DioException catch (error) {
      return Left(handleError(error.response?.data));
    } catch (error) {
      return Left(handleError(error));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> put({
    required String url,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await apiClient.put(url,
          data: data, options: Options(headers: headers));
      return Right(ServerResponse(
          status: true,
          data: response.data,
          responseHeaders: response.headers));
    } on DioException catch (error) {
      return Left(handleError(error.response?.data));
    } catch (error) {
      return Left(handleError(error));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> delete(
    String url, {
    Object? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await apiClient.delete(url,
          data: body, options: Options(headers: headers));
      if (response.statusCode == 204) {
        return Right(ServerResponse(status: true, data: {}));
      } else {
        return Right(ServerResponse(status: false, data: response.data ?? {}));
      }
    } on DioException catch (error) {
      throw Left(handleError(error.response?.data));
    } catch (error) {
      throw Left(handleError(error));
    }
  }

  @override
  Future<Either<Failure, ResponseBody>> streamGet(String url,
      {Map<String, dynamic>? headers, CancelToken? cancelToken}) async {
    try {
      final res = await apiClient.get<ResponseBody>(
        url,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            "Accept": "text/event-stream",
            "Cache-Control": "no-cache",
          },
          responseType: ResponseType.stream,
        ),
      );

      return Right(res.data!);
    } on DioException catch (error) {
      throw Left(handleError(error.response?.data));
    } catch (error) {
      throw Left(handleError(error));
    }
  }
}
