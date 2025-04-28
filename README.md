# Resumo.AI 📰🤖

Resumo.AI é um aplicativo Flutter que **busca notícias globais** e **gera resumos inteligentes** usando a API do **Gemini** (Google)!
O objetivo é trazer informações rápidas, resumidas e relevantes para o usuário em poucos segundos.


https://github.com/user-attachments/assets/06359e20-e4dc-4192-bdc6-23e3447311f0


---

## ✨ Funcionalidades

- Buscar notícias globais em tempo real (API Newsdata.io).
- Gerar resumo de notícias com IA (Google Gemini API).
- Salvar/Desfavoritar notícias favoritas localmente.
- Atualizar a lista de notícias com Pull-to-Refresh.
- UI moderna e responsiva (Material 3).
- Arquitetura modular e escalável (MVVM + GetIt + Provider).


---

## 🚀 Tecnologias e Packages Utilizados

- **Flutter 3.22**
- **Dio** → para chamadas HTTP
- **Provider** → gerenciamento de estado simples
- **GetIt** → injeção de dependência
- **GoRouter** → navegação declarativa
- **Flutter Dotenv** → para variáveis de ambiente (.env)

---

## 📁 Estrutura de Pastas

```plaintext
lib/
├── app/
│   ├── app.dart             # Widget raiz ResumoAIApp
│   ├── app_dependency.dart  # Injeção de dependência (GetIt)
│   ├── router.dart          # Configuração de rotas (GoRouter)
│   ├── app_theme.dart       # Configuração global de tema
│   ├── app_colors.dart      # Cores usadas no tema
│
├── core/
│   ├── service/             # Serviços HTTP (Dio + Gemini + News APIs)
│   ├── exceptions/          # Tratamento de erros HTTP
│   ├── helpers/             # Manipuladores e utilitários
│
├── models/
│   ├── news_model.dart      # Modelo de dados para notícias
│
├── viewmodels/
│   ├── news_viewmodel.dart          # Gerencia a HomeScreen (notícias)
│   ├── news_detail_viewmodel.dart   # Gerencia a tela de Detalhes (favoritar)
│
├── views/
│   ├── home_screen.dart     # Tela inicial (lista de notícias)
│   ├── news_detail_screen.dart # Tela de detalhes (resumo + salvar)
│
├── widgets/
│   ├── news_tile.dart       # Widget para cada notícia
│   ├── summary_card.dart    # Widget para mostrar o resumo gerado
│   ├── loading_indicator.dart
│   ├── empty_state_message.dart

test/
├── unit_tests/             # Testes unitários com mocks
├── integration_tests/      # Testes de integração com APIs reais
├── helpers/               # Classes auxiliares para testes
```


---

## 📜 Principais Conceitos Aplicados

- **MVVM Architecture**:
  - View → HomeScreen, NewsDetailScreen
  - ViewModel → NewsViewModel, NewsDetailViewModel
  - Model → NewsModel

- **Injeção de Dependência**:
  - GetIt para injetar serviços e viewmodels.

- **Gerenciamento de Estado**:
  - Provider com ChangeNotifier.

- **Chamadas HTTP**:
  - Dio para comunicação com GNews e Gemini APIs.

- **Organização Modular**:
  - Cada responsabilidade separada em pasta própria (app, core, models, viewmodels, views, widgets).

---

## 🧪 Testes

O projeto implementa uma estratégia de testes abrangente, com diferentes tipos de testes:

### Testes Unitários

- Localizados em `test/unit_tests/`
- Usam **Mocktail** para simular dependências externas
- Testam componentes isoladamente (serviços, viewmodels, etc.)
- Executados rapidamente sem dependências externas
- Verificam o comportamento esperado de classes individuais

### Testes de Integração

- Localizados em `test/integration_tests/`
- Realizam chamadas reais às APIs (NewsData.io e Gemini)
- Verificam a integração e compatibilidade com serviços externos
- Controlados pela constante `RUN_REAL_API_CALLS` (desativada por padrão)
- Requerem chaves de API válidas no arquivo `.env.test`

### Como Executar os Testes

**Testes Unitários:**
```bash
flutter test test/unit_tests/
```

**Testes de Integração:**
Para executar testes de integração, primeiro configure o arquivo `.env.test` com chaves válidas e ative os testes:

1. Abra os arquivos de teste desejados em `test/integration_tests/`
2. Altere a constante `RUN_REAL_API_CALLS = true`
3. Execute:
```bash
flutter test test/integration_tests/
```

**Todos os testes:**
```bash
flutter test
```

### Boas Práticas Implementadas

- Separação clara entre testes unitários e de integração
- Uso de mocks para isolar componentes e evitar chamadas reais em testes unitários
- Configuração de ambiente de teste via `TestDotEnv.setup()`
- Testes de diferentes cenários (sucesso, erro, dados vazios)
- Verificações detalhadas do comportamento esperado

---

## 📈 Melhorias Futuras

- Persistência local de notícias favoritas com Hive ou SharedPreferences.
- Implementar modo Offline.
- Suporte para múltiplos idiomas.
- Tela dedicada para visualizar "Favoritos".
- Sistema de autenticação e login para salvar favoritos em nuvem.

---

## 🔥 Como Rodar Localmente

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/resumo_ai.git
cd resumo_ai
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Configure o arquivo `.env` na raiz:

```dotenv
NEWS_API_KEY=your_news_api_key
GEMINI_API_KEY=your_gemini_api_key
```

4. Execute o app:

```bash
flutter run
```

---

## 👨‍💻 Autor

Projeto desenvolvido por **Felipe Angeli Trebien**.

Se quiser acompanhar mais projetos incríveis: [LinkedIn](https://www.linkedin.com/in/felipeangeli/)


---

### 🚀 Resumo.AI: Informação rápida, na palma da sua mão.
