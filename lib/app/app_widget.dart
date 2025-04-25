import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumo_ai/app/app_dependency.dart';
import 'package:resumo_ai/app/router.dart';
import 'package:resumo_ai/viewmodels/news_viewmodel.dart';
import 'app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => app_dependency<NewsViewModel>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Resumo.AI',
        theme: appTheme, // ✅ Usa o appTheme que criamos
        routerConfig: router,
      ),
    );
  }
}
