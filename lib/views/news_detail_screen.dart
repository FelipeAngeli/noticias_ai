import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../viewmodels/news_viewmodel.dart';
import '../viewmodels/news_detail_viewmodel.dart';
import '../widgets/summary_card.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewsViewModel>();
    final detailVM = context.watch<NewsDetailViewModel>();

    final isContentInvalid = article.content.trim().isEmpty ||
        article.content.contains('ONLY AVAILABLE IN PAID PLANS');
    final hasDescription = article.description.trim().isNotEmpty;
    final isSaved = detailVM.isSaved(article);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notícia'),
        actions: [
          IconButton(
            onPressed: () {
              detailVM.toggleSave(article);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isSaved
                        ? 'Notícia removida dos salvos.'
                        : 'Notícia salva com sucesso!',
                  ),
                ),
              );
            },
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.amber : null,
            ),
            tooltip: 'Salvar notícia',
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.image.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 200),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.publishedAt,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    if (isContentInvalid && !hasDescription) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Não é possível gerar resumo para esta notícia.',
                          ),
                        ),
                      );
                      return;
                    }

                    final textToSummarize = isContentInvalid
                        ? article.description
                        : article.content;

                    vm.summarize(textToSummarize);
                  },
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Gerar resumo'),
                ),
                const SizedBox(height: 16),
                Text(
                  hasDescription
                      ? article.description
                      : 'Esta notícia não possui descrição.',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          if (vm.summary.isNotEmpty)
            Positioned.fill(
              child: SummaryCard(
                summary: vm.summary,
                onClose: vm.clearSummary,
              ),
            ),
        ],
      ),
    );
  }
}
