import 'package:flutter/material.dart';
import 'package:resumo_ai/core/services/gnews_service.dart';
import '../core/services/gemini_service.dart';
import '../models/news_model.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsDataService _newsService;
  final GeminiService _geminiService;

  NewsViewModel(this._newsService, this._geminiService);

  List<NewsArticle> _articles = [];
  List<NewsArticle> get articles => _articles;

  String _summary = '';
  String get summary => _summary;

  bool _loading = false;
  bool get isLoading => _loading;

  Future<void> loadNews() async {
    _loading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchTopHeadlines();
    } catch (e) {
      _articles = [];
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> summarize(String content) async {
    _summary = '';
    notifyListeners();

    // Evita enviar conteúdo inválido
    if (content.trim().isEmpty ||
        content.contains('ONLY AVAILABLE IN PAID PLANS')) {
      _summary =
          'O conteúdo completo desta notícia não está disponível para resumo.';
      notifyListeners();
      return;
    }

    try {
      _summary = await _geminiService.summarizeText(content);
    } catch (e) {
      _summary = 'Erro ao gerar resumo.';
    }

    notifyListeners();
  }

  void clearSummary() {
    _summary = '';
    notifyListeners();
  }
}
