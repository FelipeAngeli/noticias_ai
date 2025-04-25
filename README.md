# Resumo.AI 📰🤖

Resumo.AI é um aplicativo Flutter que **busca notícias globais** e **gera resumos inteligentes** usando a API do **Gemini** (Google)!
O objetivo é trazer informações rápidas, resumidas e relevantes para o usuário em poucos segundos.

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