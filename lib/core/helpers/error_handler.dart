import 'package:dio/dio.dart';
import '../exceptions/app_exceptions.dart';

AppException handleDioError(DioException error) {
  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    return NetworkException();
  }

  if (error.response != null) {
    final statusCode = error.response!.statusCode ?? 500;
    switch (statusCode) {
      case 401:
        return UnauthorizedException();
      case 400:
      case 403:
      case 404:
      case 422:
        return ApiException(
            'Erro ${error.response?.statusMessage ?? 'desconhecido'}');
      default:
        return ApiException('Erro inesperado da API');
    }
  }

  return UnknownException(error.message ?? 'Erro desconhecido');
}
