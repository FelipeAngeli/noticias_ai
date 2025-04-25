import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resumo_ai/core/services/gemini_service.dart';
import 'package:resumo_ai/core/services/gnews_service.dart';
import 'package:resumo_ai/models/news_model.dart';
import 'package:resumo_ai/viewmodels/news_viewmodel.dart';

class MockNewsDataService extends Mock implements NewsDataService {}

class MockGeminiService extends Mock implements GeminiService {}

void main() {
  group('NewsViewModel', () {
    late NewsViewModel viewModel;
    late MockNewsDataService mockNewsService;
    late MockGeminiService mockGeminiService;

    setUp(() {
      mockNewsService = MockNewsDataService();
      mockGeminiService = MockGeminiService();
      viewModel = NewsViewModel(mockNewsService, mockGeminiService);

      registerFallbackValue('');
    });

    test('loadNews deve atualizar a lista de artigos corretamente', () async {
      final mockArticles = [
        NewsArticle(
          title: 'Título de teste',
          description: 'Descrição de teste',
          content: 'Conteúdo de teste',
          url: 'https://example.com',
          image: 'https://example.com/image.jpg',
          publishedAt: '2023-06-15T14:30:00Z',
          source: 'Fonte de teste',
        ),
      ];

      when(() => mockNewsService.fetchTopHeadlines())
          .thenAnswer((_) async => mockArticles);

      await viewModel.loadNews();

      expect(viewModel.articles, mockArticles);
      expect(viewModel.isLoading, false);
      verify(() => mockNewsService.fetchTopHeadlines()).called(1);
    });

    test('loadNews deve lidar com erros e definir lista vazia', () async {
      when(() => mockNewsService.fetchTopHeadlines())
          .thenThrow(Exception('Erro ao carregar notícias'));

      await viewModel.loadNews();

      expect(viewModel.articles, isEmpty);
      expect(viewModel.isLoading, false);
      verify(() => mockNewsService.fetchTopHeadlines()).called(1);
    });

    test('summarize deve atualizar o resumo corretamente', () async {
      const mockSummary = 'Este é um resumo de teste.';
      when(() => mockGeminiService.summarizeText(any()))
          .thenAnswer((_) async => mockSummary);

      await viewModel.summarize('Conteúdo para resumir');

      expect(viewModel.summary, mockSummary);
      verify(() => mockGeminiService.summarizeText(any())).called(1);
    });

    test('summarize deve lidar com erros', () async {
      when(() => mockGeminiService.summarizeText(any()))
          .thenThrow(Exception('Erro ao gerar resumo'));

      await viewModel.summarize('Conteúdo para resumir');

      expect(viewModel.summary, 'Erro ao gerar resumo.');
      verify(() => mockGeminiService.summarizeText(any())).called(1);
    });

    test('summarize deve lidar com conteúdo vazio ou indisponível', () async {
      await viewModel.summarize('ONLY AVAILABLE IN PAID PLANS');

      expect(viewModel.summary,
          'O conteúdo completo desta notícia não está disponível para resumo.');
      verifyNever(() => mockGeminiService.summarizeText(any()));
    });

    test('clearSummary deve limpar o resumo', () {
      viewModel = NewsViewModel(mockNewsService, mockGeminiService);

      viewModel.summarize('Conteúdo para resumir');

      viewModel.clearSummary();

      expect(viewModel.summary, '');
    });
  });
}
