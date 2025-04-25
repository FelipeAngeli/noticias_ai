import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/news_model.dart';
import 'http_client_service.dart';
import '../helpers/error_handler.dart';
import '../exceptions/app_exceptions.dart';

class NewsDataService {
  final HttpClientService _http;
  final String _apiKey = dotenv.env['NEWSDATA_API_KEY'] ?? '';
  final String _baseUrl = 'https://newsdata.io/api/1';

  NewsDataService(this._http);

  Future<List<NewsArticle>> fetchTopHeadlines(
      {String? category, String? query}) async {
    try {
      final Map<String, dynamic> queryParams = {
        'apikey': _apiKey,
        'country': 'br',
        'language': 'pt',
      };

      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      if (query != null && query.isNotEmpty) {
        queryParams['q'] = query;
      }

      final response = await _http.get(
        '$_baseUrl/latest',
        queryParameters: queryParams,
      );

      final List articles = response.data['results'];
      return articles
          .map((json) => NewsArticle(
                title: json['title'] ?? '',
                description: json['description'] ?? '',
                content: json['content'] ?? '',
                url: json['link'] ?? '',
                image: json['image_url'] ?? '',
                publishedAt: json['pubDate'] ?? '',
                source: json['source_id'] ?? '',
              ))
          .toList();
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (_) {
      throw UnknownException();
    }
  }
}
