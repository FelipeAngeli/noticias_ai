import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsDetailViewModel extends ChangeNotifier {
  final List<NewsArticle> _saved = [];

  bool isSaved(NewsArticle article) {
    return _saved
        .any((a) => a.title == article.title && a.source == article.source);
  }

  void save(NewsArticle article) {
    if (!isSaved(article)) {
      _saved.add(article);
      notifyListeners();
    }
  }

  void toggleSave(NewsArticle article) {
    if (isSaved(article)) {
      _saved.removeWhere(
        (a) => a.title == article.title && a.source == article.source,
      );
    } else {
      _saved.add(article);
    }
    notifyListeners();
  }

  List<NewsArticle> get savedArticles => List.unmodifiable(_saved);
}
