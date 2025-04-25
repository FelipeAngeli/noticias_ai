import 'package:dio/dio.dart';
import 'app_interceptor.dart';

class HttpClientService {
  final Dio _dio;

  HttpClientService({BaseOptions? options})
      : _dio = Dio(options ?? BaseOptions()) {
    _dio.interceptors.add(AppInterceptor());
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Dio get dio => _dio;
}
