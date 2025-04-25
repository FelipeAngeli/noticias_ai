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
    });

    group('fetchTopHeadlines', () {
      test('deve obter notícias sem filtros', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        final noticias = await newsService.fetchTopHeadlines();

        expect(noticias, isA<List<NewsArticle>>());
        expect(noticias, isNotEmpty);

        for (var noticia in noticias) {
          expect(noticia.title, isNotEmpty);
          expect(noticia.url, isNotEmpty);
        }

        print('Número de notícias obtidas: ${noticias.length}');
        if (noticias.isNotEmpty) {
          print('Primeira notícia: ${noticias.first.title}');
        }
      }, timeout: Timeout(Duration(seconds: 30)));

      test('deve obter notícias com filtro de categoria', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const categoria = 'technology';

        final noticias =
            await newsService.fetchTopHeadlines(category: categoria);

        expect(noticias, isA<List<NewsArticle>>());

        print('Número de notícias na categoria $categoria: ${noticias.length}');
        if (noticias.isNotEmpty) {
          print('Primeira notícia: ${noticias.first.title}');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve obter notícias com termo de busca', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const termo = 'inteligência artificial';

        final noticias = await newsService.fetchTopHeadlines(query: termo);

        expect(noticias, isA<List<NewsArticle>>());

        print('Número de notícias com o termo "$termo": ${noticias.length}');
        if (noticias.isNotEmpty) {
          print('Primeira notícia: ${noticias.first.title}');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve obter notícias combinando categoria e termo de busca',
          () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const categoria = 'business';
        const termo = 'economia';

        final noticias = await newsService.fetchTopHeadlines(
          category: categoria,
          query: termo,
        );

        expect(noticias, isA<List<NewsArticle>>());

        print(
            'Número de notícias na categoria $categoria com termo "$termo": ${noticias.length}');
        if (noticias.isNotEmpty) {
          print('Primeira notícia: ${noticias.first.title}');
        }
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}
