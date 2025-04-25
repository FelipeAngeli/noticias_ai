import 'package:get_it/get_it.dart';
import 'package:resumo_ai/viewmodels/news_detail_viewmodel.dart';
import '../core/services/http_client_service.dart';
import '../core/services/gnews_service.dart';
import '../core/services/gemini_service.dart';
import '../viewmodels/news_viewmodel.dart';

final app_dependency = GetIt.instance;

void setupLocator() {
  // Services
  app_dependency.registerLazySingleton(() => HttpClientService());
  app_dependency.registerLazySingleton(() => GeminiService(app_dependency()));
  app_dependency.registerLazySingleton(() => NewsDataService(app_dependency()));

  // ViewModels
  app_dependency
      .registerFactory(() => NewsViewModel(app_dependency(), app_dependency()));
  app_dependency.registerFactory(() => NewsDetailViewModel());
}
