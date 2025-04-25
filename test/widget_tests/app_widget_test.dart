import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resumo_ai/app/app_widget.dart';
import 'package:resumo_ai/core/services/gemini_service.dart';
import 'package:resumo_ai/core/services/gnews_service.dart';
import 'package:resumo_ai/viewmodels/news_viewmodel.dart';
import 'package:resumo_ai/viewmodels/news_detail_viewmodel.dart';
import '../helpers/dotenv_setup.dart';

class MockNewsDataService extends Mock implements NewsDataService {}

class MockGeminiService extends Mock implements GeminiService {}

class MockNewsViewModel extends Mock implements NewsViewModel {}

class MockNewsDetailViewModel extends Mock implements NewsDetailViewModel {}

void main() {
  setUpAll(() async {
    await TestDotEnv.setup();
  });

  setUp(() {
    GetIt.instance.reset();

    final mockNewsService = MockNewsDataService();
    final mockGeminiService = MockGeminiService();
    final mockNewsViewModel = MockNewsViewModel();
    final mockNewsDetailViewModel = MockNewsDetailViewModel();

    GetIt.instance.registerSingleton<NewsDataService>(mockNewsService);
    GetIt.instance.registerSingleton<GeminiService>(mockGeminiService);
    GetIt.instance.registerSingleton<NewsViewModel>(mockNewsViewModel);
    GetIt.instance
        .registerSingleton<NewsDetailViewModel>(mockNewsDetailViewModel);

    when(() => mockNewsViewModel.articles).thenReturn([]);
    when(() => mockNewsViewModel.isLoading).thenReturn(false);
    when(() => mockNewsViewModel.loadNews())
        .thenAnswer((_) async => Future<void>.value());
    when(() => mockNewsViewModel.summary).thenReturn('');
  });

  testWidgets('AppWidget deve renderizar corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppWidget());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
