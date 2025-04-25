import 'package:flutter_test/flutter_test.dart';
import 'package:resumo_ai/core/services/gemini_service.dart';
import 'package:resumo_ai/core/services/http_client_service.dart';
import '../../helpers/dotenv_setup.dart';

const bool RUN_REAL_API_CALLS = false;

void main() {
  setUpAll(() async {
    await TestDotEnv.setup();
  });

  group('GeminiService - Testes de Integração', () {
    late GeminiService geminiService;
    late HttpClientService httpService;

    setUp(() {
      httpService = HttpClientService();
      geminiService = GeminiService(httpService);
    });

    group('Inicialização', () {
      test('deve inicializar corretamente', () {
        expect(geminiService, isNotNull);
      });
    });

    group('summarizeText', () {
      test('deve resumir um texto curto corretamente', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const textoParaResumir = '''
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nisl eget ultricies lacinia, 
        nisl nisl aliquet nisl, eget aliquet nisl nisl eget nisl. Nullam auctor, nisl eget ultricies lacinia, 
        nisl nisl aliquet nisl, eget aliquet nisl nisl eget nisl.
        ''';

        final resumo = await geminiService.summarizeText(textoParaResumir);

        expect(resumo, isNotEmpty);
        expect(resumo.length, lessThan(textoParaResumir.length));

        print('Resumo obtido: $resumo');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve resumir um texto longo corretamente', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const textoLongo = '''
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        
        Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, 
        totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. 
        Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui 
        ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, 
        adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.
        ''';

        final resumo = await geminiService.summarizeText(textoLongo);

        expect(resumo, isNotEmpty);
        expect(resumo.length, lessThan(textoLongo.length));

        print('Resumo de texto longo: $resumo');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve lidar com texto em português corretamente', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const textoPortugues = '''
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in finibus turpis. 
        Nulla facilisi. Phasellus gravida nulla vel diam faucibus, sed pharetra sapien tincidunt. 
        In hac habitasse platea dictumst. Phasellus viverra nisl in dolor ultricies, vel placerat sem finibus. 
        Morbi vehicula lorem at tellus tempus, vel tempor eros semper.
        ''';

        final resumo = await geminiService.summarizeText(textoPortugues);

        expect(resumo, isNotEmpty);
        expect(resumo.length, lessThan(textoPortugues.length));

        print('Resumo em português: $resumo');
      }, timeout: const Timeout(Duration(seconds: 30)));

      test('deve lançar exceção para texto vazio', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        expect(
          () => geminiService.summarizeText(''),
          throwsException,
        );
      });

      test('deve lidar com texto muito curto', () async {
        if (!RUN_REAL_API_CALLS) {
          print(
              'Teste pulado: Configure RUN_REAL_API_CALLS = true para executar.');
          return;
        }

        const textoCurto = 'Lorem ipsum.';

        final resumo = await geminiService.summarizeText(textoCurto);

        expect(resumo, isNotEmpty);

        print('Resumo de texto curto: $resumo');
      }, timeout: const Timeout(Duration(seconds: 30)));
    });
  });
}
