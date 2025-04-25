import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resumo_ai/app/app_dependency.dart';
import '../views/home_screen.dart';
import '../views/news_detail_screen.dart';
import '../models/news_model.dart';
import '../viewmodels/news_detail_viewmodel.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details',
      name: 'details',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final article = data['article'] as NewsArticle;

        return ChangeNotifierProvider(
          create: (_) => app_dependency<NewsDetailViewModel>(),
          child: NewsDetailScreen(article: article),
        );
      },
    ),
  ],
);
