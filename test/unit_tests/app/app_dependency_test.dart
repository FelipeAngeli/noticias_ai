import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resumo_ai/app/app_dependency.dart';
import 'package:resumo_ai/core/services/gemini_service.dart';
import 'package:resumo_ai/core/services/gnews_service.dart';
import 'package:resumo_ai/core/services/http_client_service.dart';
import 'package:resumo_ai/viewmodels/news_detail_viewmodel.dart';
import 'package:resumo_ai/viewmodels/news_viewmodel.dart';
import '../../helpers/dotenv_setup.dart';

class MockAppDependencies extends Mock {
  void setupLocator() {}
}

void main() {
  setUpAll(() async {
    await TestDotEnv.setup();
  });

  group('AppDependency', () {
    setUp(() {
      GetIt.instance.reset();
    });

    test('setupLocator deve registrar todos os serviços e viewmodels', () {
      setupLocator();

      expect(GetIt.instance.isRegistered<HttpClientService>(), true);
      expect(GetIt.instance.isRegistered<NewsDataService>(), true);
      expect(GetIt.instance.isRegistered<GeminiService>(), true);
      expect(GetIt.instance.isRegistered<NewsViewModel>(), true);
      expect(GetIt.instance.isRegistered<NewsDetailViewModel>(), true);
    });

    test('todos os serviços devem ser registrados como singleton', () {
      setupLocator();

      final httpService1 = GetIt.instance<HttpClientService>();
      final httpService2 = GetIt.instance<HttpClientService>();
      expect(identical(httpService1, httpService2), true);

      final newsService1 = GetIt.instance<NewsDataService>();
      final newsService2 = GetIt.instance<NewsDataService>();
      expect(identical(newsService1, newsService2), true);

      final geminiService1 = GetIt.instance<GeminiService>();
      final geminiService2 = GetIt.instance<GeminiService>();
      expect(identical(geminiService1, geminiService2), true);
    });

    test('os viewmodels devem ser registrados corretamente', () {
      setupLocator();

      final newsViewModel = GetIt.instance<NewsViewModel>();
      final newsDetailViewModel = GetIt.instance<NewsDetailViewModel>();

      expect(newsViewModel, isA<NewsViewModel>());
      expect(newsDetailViewModel, isA<NewsDetailViewModel>());
    });
  });
}
