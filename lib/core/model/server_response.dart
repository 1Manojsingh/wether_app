import 'package:dio/dio.dart';

class ServerResponse<T> {
  ServerResponse({
    this.status = true,
    required this.data,
    this.responseHeaders,
  });

  bool status;
  T data;
  Headers? responseHeaders;
}
