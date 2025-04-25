import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TestDotEnv {
  static final Map<String, String> _defaultTestValues = {
    'NEWSDATA_API_KEY': 'chave_de_teste_newsdata',
    'GEMINI_API_KEY': 'chave_de_teste_gemini',
  };

  static Future<void> setup() async {
    bool envLoaded = false;

    if (await _fileExists('.env.test')) {
      try {
        await dotenv.load(fileName: '.env.test');
        print('✅ Arquivo .env.test carregado com sucesso');
        envLoaded = true;
      } catch (e) {
        print('⚠️ Erro ao carregar .env.test: $e');
      }
    }

    if (!envLoaded && await _fileExists('.env')) {
      try {
        await dotenv.load();
        print('✅ Arquivo .env carregado com sucesso');
        envLoaded = true;
      } catch (e) {
        print('⚠️ Erro ao carregar .env: $e');
      }
    }

    if (!envLoaded) {
      try {
        await dotenv.load(fileName: '.env-notfound');
      } catch (e) {
        // Ignora erro esperado
      }
      print(
          'ℹ️ Nenhum arquivo .env encontrado, usando valores padrão de teste');
    }

    for (var entry in _defaultTestValues.entries) {
      if (dotenv.env[entry.key]?.isEmpty ?? true) {
        dotenv.env[entry.key] = entry.value;
      }
    }
  }

  static Future<bool> _fileExists(String path) async {
    return await File(path).exists();
  }

  static Map<String, String> get loadedValues {
    final Map<String, String> values = {};
    for (var key in _defaultTestValues.keys) {
      values[key] = dotenv.env[key] ?? 'não definido';
    }
    return values;
  }
}
