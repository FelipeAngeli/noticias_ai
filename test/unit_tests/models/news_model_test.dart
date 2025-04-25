import 'package:flutter_test/flutter_test.dart';
import 'package:resumo_ai/models/news_model.dart';

void main() {
  group('NewsArticle', () {
    test('deve criar uma instância corretamente a partir de um construtor', () {
      final newsArticle = NewsArticle(
        title: 'Título de teste',
        description: 'Descrição de teste',
        content: 'Conteúdo de teste',
        url: 'https://example.com',
        image: 'https://example.com/image.jpg',
        publishedAt: '2023-06-15T14:30:00Z',
        source: 'Fonte de teste',
      );

      // Assert
      expect(newsArticle.title, 'Título de teste');
      expect(newsArticle.description, 'Descrição de teste');
      expect(newsArticle.content, 'Conteúdo de teste');
      expect(newsArticle.url, 'https://example.com');
      expect(newsArticle.image, 'https://example.com/image.jpg');
      expect(newsArticle.publishedAt, '2023-06-15T14:30:00Z');
      expect(newsArticle.source, 'Fonte de teste');
    });

    test('deve criar uma instância corretamente a partir de JSON', () {
      final json = {
        'title': 'Título de teste',
        'description': 'Descrição de teste',
        'content': 'Conteúdo de teste',
        'url': 'https://example.com',
        'image': 'https://example.com/image.jpg',
        'publishedAt': '2023-06-15T14:30:00Z',
        'source': {'name': 'Fonte de teste'},
      };

      final newsArticle = NewsArticle.fromJson(json);

      expect(newsArticle.title, 'Título de teste');
      expect(newsArticle.description, 'Descrição de teste');
      expect(newsArticle.content, 'Conteúdo de teste');
      expect(newsArticle.url, 'https://example.com');
      expect(newsArticle.image, 'https://example.com/image.jpg');
      expect(newsArticle.publishedAt, '2023-06-15T14:30:00Z');
      expect(newsArticle.source, 'Fonte de teste');
    });

    test('deve lidar com valores nulos no JSON', () {
      final json = {
        'source': {},
      };

      final newsArticle = NewsArticle.fromJson(json);

      expect(newsArticle.title, '');
      expect(newsArticle.description, '');
      expect(newsArticle.content, '');
      expect(newsArticle.url, '');
      expect(newsArticle.image, '');
      expect(newsArticle.publishedAt, '');
      expect(newsArticle.source, '');
    });
  });
}
