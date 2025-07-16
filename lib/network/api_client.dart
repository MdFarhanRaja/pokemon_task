import 'package:dio/dio.dart';

import 'api_constants.dart';

class ApiClient {
  static const timeoutTime = Duration(minutes: 5);

  static Dio getInstance({String? baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? ApiConstants.baseUrl,
      connectTimeout: timeoutTime,
      receiveTimeout: timeoutTime,
    );

    Dio dio = Dio(options);
    return dio;
  }
}
