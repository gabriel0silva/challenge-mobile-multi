# 🎬 Flutter Movies App - Desafio Técnico

Seja bem-vindo ao repositório do desafio técnico!  
Este projeto foi desenvolvido com foco em boas práticas, escalabilidade, organização e uso dos recursos Flutter.

---

## ✅ Como rodar o projeto

### 🔧 Requisitos

- Flutter SDK **3.29.2**
- Dart **3.7.2**
- Acesso à internet (a aplicação consome dados da API TMDb)

### ▶️ Comandos para executar

```bash
# Clone o repositório
git clone https://github.com/gabriel0silva/challenge-mobile-multi.git
cd seu-repositorio

# Instale as dependências
flutter pub get

# Rode o app
flutter run

# Execute os testes
flutter test
```

---

## 💡 O que foi implementado

### 🧱 Arquitetura

Aplicação construída com **MVVM (Model-View-ViewModel)**, facilitando a separação de responsabilidades e a testabilidade.

Estrutura baseada nos princípios da **Clean Architecture** e **SOLID**:

- Camadas bem definidas: `presentation`, `domain`, `data`.
- Baixo acoplamento com uso de **interfaces** e **injeção de dependência** (via `GetIt`).
- Modularidade e reutilização com **extensions**, **utils** e **widgets genéricos**.

---

### ⚙️ Boas práticas e organização

- Gerenciamento de estado com **Provider**
- Injeção de dependências com **GetIt**
- Requisições HTTP usando **Dio**
- Estrutura clara com pastas como: `models`, `usecases`, `repositories`, `viewmodels`, `widgets`
- Manipulação de erros e mensagens de forma segura e clara

---

### 📱 Funcionalidades principais

- **Layout Responsivo** e adaptado
- **Carrossel de filmes** com os "Melhores avaliados"
- Seções "**Nos cinemas**" e "**Em breve**" com **paginação implementada** por meio de scroll infinito
- **Reprodução de trailers via YouTube**, com integração ao `youtube_player_flutter` (Caso não exista o trailer cadastrado o usuáio é levado ao youtube com o nome do filme já pesquisado)
- **Splash Screen** com animação
- **Internacionalização (i18n)** com suporte a `pt-BR` e `en-US`, troca dinâmica de idioma
- Estrutura pronta para **testes unitários** com cobertura das camadas de domínio, serviços e viewmodels

---

### 📂 Estrutura de pastas

```bash
lib/
├── l10n/               # Traduções JSON
├── app/
│   ├── core/           # Constantes, extensions, utils, exceções
│   ├── data/           # Models, datasources e implementação de repositórios
│   ├── domain/         # Entidades, repositórios abstratos, usecases
│   ├── presentation/   # Telas, widgets, viewmodels
│   ├── routes/         # Rotas nomeadas centralizadas
│   ├── services/       # Serviços como Dio e tradução
│   ├── di/             # Injeção de dependência
└── main.dart           # Entry point
```

---

### 🧪 Testes

Testes unitários implementados para:

- Use Cases
- Repositórios
- Services (como `DioService` e `TranslationService`)
- ViewModels
- Extensions

Mocks criados com **mocktail**.

```bash
flutter test
```

---

### 📚 Tecnologias e bibliotecas

- Dio
- Provider
- GetIt
- Flutter DotEnv
- Youtube Player Flutter
- flutter_localizations
- mocktail
- flutter_test
- Lottie

---

## 📱 Disponibilidade e Instalação

Este aplicativo está disponível para **Android** e **iOS**, e foi testado com sucesso em ambos os sistemas operacionais.

### 🔗 Instalação Android
Você pode baixar e instalar o APK diretamente em um dispositivo Android:

- [🔽 Download APK](./releases/app-release.apk)

> ⚠️ Certifique-se de permitir a instalação de apps de fontes desconhecidas no seu dispositivo Android para conseguir instalar o APK.

### 🍏 Instalação iOS
Para rodar no iOS, basta executar o projeto via Xcode em um simulador ou dispositivo real com o Flutter configurado para iOS.

> Este projeto já está pronto e compatível com iOS, e pode ser buildado normalmente com `flutter run` ou `flutter build ios`.

---

### 🎯 Considerações finais

Todo o projeto foi estruturado com atenção aos detalhes e foco em qualidade de código, seguindo as recomendações descritas no desafio.  