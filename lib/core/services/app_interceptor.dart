import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Adiciona headers personalizados
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer SEU_TOKEN_AQUI' // se necessário
    });

    // Log da requisição
    print('[REQ] ${options.method} ${options.uri}');
    print('[REQ-HEADERS] ${options.headers}');
    if (options.data != null) print('[REQ-DATA] ${options.data}');

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log da resposta
    print('[RES] ${response.statusCode} ${response.requestOptions.uri}');
    print('[RES-DATA] ${response.data}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[ERR] ${err.requestOptions.uri}');
    print('[ERR-MSG] ${err.message}');
    return handler.next(err);
  }
}
