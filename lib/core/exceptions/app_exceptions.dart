abstract class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class NetworkException extends AppException {
  NetworkException([String message = 'Sem conexão com a internet'])
      : super(message);
}

class ApiException extends AppException {
  ApiException([String message = 'Erro na comunicação com a API'])
      : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Acesso não autorizado'])
      : super(message, 401);
}

class UnknownException extends AppException {
  UnknownException([String message = 'Erro desconhecido']) : super(message);
}
