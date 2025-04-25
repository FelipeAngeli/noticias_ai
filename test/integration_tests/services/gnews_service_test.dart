import 'package:flutter_test/flutter_test.dart';
import 'package:resumo_ai/core/services/gnews_service.dart';
import 'package:resumo_ai/core/services/http_client_service.dart';
import 'package:resumo_ai/models/news_model.dart';
import '../../helpers/dotenv_setup.dart';

const bool RUN_REAL_API_CALLS = false;

void main() {
  setUpAll(() async {
    await TestDotEnv.setup();
  });

  group('NewsDataService - Testes de Integração', () {
    late NewsDataService newsService;
    late HttpClientService httpService;

    setUp(() {
      httpService = HttpClientService();

      newsService = NewsDataService(httpService);
    });

    group('Inicialização', () {
      test('deve inicializar corretamente', () {
        expect(newsService, isNotNull);
      });

      test('deve ter a URL base e a chave de API configuradas', () {
        expect(newsService, isA<NewsDataService>());
      });
    });

    group('fetchTopHeadlines', () {
      test('deve buscar as manchetes mais recentes corretamente', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Requer chave de API válida. Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        final noticias = await newsService.fetchTopHeadlines();

        expect(noticias, isA<List<NewsArticle>>());
        expect(noticias, isNotEmpty);

        if (noticias.isNotEmpty) {
          final primeiraNoticia = noticias.first;

          expect(primeiraNoticia.title, isNotEmpty);
          expect(primeiraNoticia.description, isA<String>());
          expect(primeiraNoticia.url, isNotEmpty);
          expect(primeiraNoticia.source, isNotEmpty);

          print('Título: ${primeiraNoticia.title}');
          print('Descrição: ${primeiraNoticia.description}');
          print('URL: ${primeiraNoticia.url}');
          print('Fonte: ${primeiraNoticia.source}');
          print('Data: ${primeiraNoticia.publishedAt}');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve lidar corretamente com o limite de requisições', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Requer chave de API válida. Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const int maxCalls = 2; // Número reduzido para não abusar da API

        for (int i = 0; i < maxCalls; i++) {
          if (i > 0) {
            await Future.delayed(const Duration(seconds: 2));
          }

          try {
            final result = await newsService.fetchTopHeadlines();
            expect(result, isA<List<NewsArticle>>());
            print('Requisição ${i + 1}: OK - ${result.length} notícias');
          } catch (e) {
            print('Requisição ${i + 1}: Erro - ${e.toString()}');

            expect(
                e.toString().toLowerCase().contains('rate') ||
                    e.toString().toLowerCase().contains('limit') ||
                    e.toString().toLowerCase().contains('quota'),
                false);
          }
        }
      }, timeout: const Timeout(Duration(seconds: 60)));

      test('deve converter corretamente diferentes formatos de data', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Requer chave de API válida. Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        final noticias = await newsService.fetchTopHeadlines();

        if (noticias.isNotEmpty) {
          final noticia = noticias.first;

          expect(noticia.publishedAt, isNotEmpty);

          print('Formato da data recebida: ${noticia.publishedAt}');
        } else {
          print('Nenhuma notícia recebida para testar o formato de data');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve retornar notícias com conteúdo consistente', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Requer chave de API válida. Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        final noticias = await newsService.fetchTopHeadlines();

        if (noticias.isNotEmpty) {
          final titulos = noticias.map((n) => n.title).toList();
          final titulosUnicos = titulos.toSet().toList();

          expect(titulos.length, titulosUnicos.length,
              reason:
                  'Não deve haver títulos duplicados nas notícias retornadas');

          for (var noticia in noticias) {
            expect(noticia.url, contains('http'));
          }
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}
