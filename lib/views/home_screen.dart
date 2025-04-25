import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/news_viewmodel.dart';
import '../widgets/news_tile.dart';
import '../widgets/empty_state_message.dart';
import '../widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsViewModel>().loadNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo.AI')),
      body: Consumer<NewsViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading && vm.articles.isEmpty) {
            return const LoadingIndicator();
          }

          if (vm.articles.isEmpty) {
            return const EmptyStateMessage(
                message: 'Nenhuma notícia encontrada.');
          }

          return RefreshIndicator(
            onRefresh: () async =>
                await context.read<NewsViewModel>().loadNews(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: vm.articles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => NewsTile(article: vm.articles[index]),
            ),
          );
        },
      ),
    );
  }
}
