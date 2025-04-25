import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'http_client_service.dart';
import '../helpers/error_handler.dart';
import '../exceptions/app_exceptions.dart';

class GeminiService {
  final HttpClientService _http;

  GeminiService(this._http);

  final String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  final String _model = 'gemini-2.0-flash'; // ou 'gemini-pro' se preferir
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<String> summarizeText(String input) async {
    try {
      final response = await _http.post(
        '$_baseUrl/$_model:generateContent',
        queryParameters: {'key': _apiKey},
        data: {
          "contents": [
            {
              "parts": [
                {"text": "Resuma o seguinte texto em 3 frases:\n$input"}
              ]
            }
          ]
        },
      );

      final summary =
          response.data['candidates'][0]['content']['parts'][0]['text'];
      return summary;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (_) {
      throw UnknownException();
    }
  }
}
