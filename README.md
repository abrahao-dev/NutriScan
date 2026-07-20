# 📱 NutriScan

> Escaneie um alimento e entenda em segundos se ele faz bem pra você.

App iOS que lê o **código de barras** de um produto (ou busca por nome), consulta a base aberta **[Open Food Facts](https://world.openfoodfacts.org/)** e traduz a tabela nutricional em informação visual: **Nutri-Score (A–E)**, destaques como *"Bom para o coração"* ou *"Alto em gordura saturada"*, e **comparação de dois produtos lado a lado**.

Projeto final do **Bootcamp Mobile iOS — MasterCode Academy** (2025/2026), desenvolvido em equipe durante o curso e **finalizado neste fork**.

---

## ✨ Funcionalidades

- 📷 **Scan de código de barras** com a câmera (AVFoundation) + digitação manual como fallback
- 🔍 **Busca por nome ou marca** com debounce e estados de erro/vazio
- 📊 **Detalhes do produto** com Nutri-Score e destaques nutricionais calculados dos dados reais da API (gordura, gordura saturada, proteínas e fibras por 100g)
- ⚖️ **Comparação** de dois produtos lado a lado (segundo produto via scan ou busca)
- ❤️ **Favoritos persistidos** localmente (UserDefaults + JSON), com swipe para remover
- 🕓 **"Salvos Recentemente"** na Home — últimos 10 produtos visualizados
- 🔐 **Login/Cadastro** com Firebase Auth, edição de perfil e redefinição de senha por e-mail
- 🧅 **Onboarding** na primeira execução

## 🏛️ Arquitetura e tecnologias

**MVVM** com **UIKit (ViewCode) + SwiftUI** interoperando — telas UIKit hospedam componentes SwiftUI (`UIHostingController`) e vice-versa (`UIViewControllerRepresentable`), refletindo codebases híbridas do mercado.

| Camada | Tecnologia |
|--------|-----------|
| UI | UIKit ViewCode + SwiftUI |
| Estado/binding | Combine (`ObservableObject`, `@Published`) |
| Rede | URLSession + camada de serviço com **DI via protocolo** (`ProductServiceProtocol`) |
| Persistência | UserDefaults + JSON (`Codable`) — `ProductStore` |
| Auth | Firebase Auth |
| Câmera | AVFoundation |
| Testes | Swift Testing (`#expect`), Given/When/Then, mocks por protocolo |

Detalhes completos (requisitos, regras de negócio, fluxo de navegação, decisões de design): **[DOCUMENTACAO.md](./NutriScan/DOCUMENTACAO.md)**

## 🚀 Como rodar

1. Clone o repositório e abra `NutriScan/NutriScan.xcodeproj` no **Xcode 16+**
2. Aguarde o SPM resolver as dependências (Firebase iOS SDK)
3. Rode no simulador (`⌘R`) — o scan de barcode exige aparelho físico; no simulador use **"Digitar"** na tela de Scan
4. Testes: `⌘U` (13 testes unitários + UI tests)

> `GoogleService-Info.plist` do projeto Firebase da equipe já está incluído.

## 🧪 Testes

```
FoodInformationTests        — regras de negócio dos destaques nutricionais
ProductStoreTests           — persistência, toggle de favoritos, dedupe/limite de recentes
OpenFoodFactsServiceTests   — mapeamento API → modelo interno, chaves do JSON real
SearchFoodsViewModelTests   — ViewModel com service mockado (DI via protocolo)
```

## 🔗 Links do projeto

| Recurso | Link |
|---------|------|
| 🎨 Design final (Figma) | [NutriScan App](https://www.figma.com/design/oEfbZ58pzE6HgwBap20CUH/NutriScan-App?node-id=0-1) |
| 🎨 UI Kit de referência (Figma Community) | [Nutrition App UI](https://www.figma.com/design/95HYnqqA0MoqmwN7ObWfqo/Nutrition-App-UI--Community-) |
| 📋 Board ágil (Trello) | [Sprint Board](https://trello.com/b/mc9AmW9S/trello-agile-sprint-board-template) |
| 📝 Documento do projeto (Notion) | [Nutri-Scan](https://app.notion.com/p/Nutri-Scan-26391ed2afc280d5a6e1de19967de4f4) |
| 🌐 API | [Open Food Facts](https://world.openfoodfacts.org/) |
| 🍴 Repositório original da equipe | [elenadiniz/NutriScan](https://github.com/elenadiniz/NutriScan) |

## 👥 Equipe

Desenvolvido durante o bootcamp por [@elenadiniz](https://github.com/elenadiniz), [@raphaelavidal](https://github.com/raphaelavidal), [@MateusAndreatta](https://github.com/MateusAndreatta), [@abrahao-dev](https://github.com/abrahao-dev) e [@EderJrDev](https://github.com/EderJrDev).

**Finalização** (dados nutricionais reais, persistência de favoritos/recentes, entrada manual de barcode, perfil funcional, testes e documentação): [@abrahao-dev](https://github.com/abrahao-dev).

## 📜 Padrão de commits

**Conventional Commits em português**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.

```
feat: adiciona tela de login com e-mail e senha
```
