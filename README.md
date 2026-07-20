# 📱 NutriScan

**English** | [Português (BR)](./README.pt-BR.md)

> Scan a food product and understand in seconds whether it's good for you.

iOS app that reads a product's **barcode** (or searches by name), queries the open **[Open Food Facts](https://world.openfoodfacts.org/)** database and translates the nutrition label into visual, actionable information: **Nutri-Score (A–E)**, highlights like *"Good for your heart"* or *"High in saturated fat"*, and a **side-by-side comparison of two products**.

Final project of the **iOS Mobile Bootcamp — MasterCode Academy** (2025/2026), built as a team during the course and **completed in this fork**.

---

## ✨ Features

- 📷 **Barcode scanning** with the camera (AVFoundation) + manual entry as fallback
- 🔍 **Search by name or brand** with debounce, error and empty states
- 📊 **Product details** with Nutri-Score and nutrition highlights computed from real API data (fat, saturated fat, protein and fiber per 100g)
- ⚖️ **Compare** two products side by side (second product via scan or search)
- ❤️ **Favorites persisted** locally (UserDefaults + JSON), with swipe to delete
- 🕓 **"Recently Viewed"** on Home — last 10 products opened
- 🔐 **Sign up / Login** with Firebase Auth, profile editing and password reset via e-mail
- 🧅 **Onboarding** on first launch

## 🏛️ Architecture & tech stack

**MVVM** with **UIKit (programmatic ViewCode) + SwiftUI** interoperating — UIKit screens host SwiftUI components (`UIHostingController`) and vice versa (`UIViewControllerRepresentable`), mirroring real-world hybrid codebases.

| Layer | Technology |
|-------|-----------|
| UI | UIKit ViewCode + SwiftUI |
| State/binding | Combine (`ObservableObject`, `@Published`) |
| Networking | URLSession + service layer with **protocol-based DI** (`ProductServiceProtocol`) |
| Persistence | UserDefaults + JSON (`Codable`) — `ProductStore` |
| Auth | Firebase Auth |
| Camera | AVFoundation |
| Tests | Swift Testing (`#expect`), Given/When/Then, protocol-based mocks |

Full documentation (requirements, business rules, navigation flow, design decisions — in Portuguese): **[DOCUMENTACAO.md](./NutriScan/DOCUMENTACAO.md)**

## 🚀 Getting started

1. Clone the repo and open `NutriScan/NutriScan.xcodeproj` in **Xcode 16+**
2. Wait for SPM to resolve dependencies (Firebase iOS SDK)
3. Run on the simulator (`⌘R`) — barcode scanning requires a physical device; on the simulator use **"Digitar"** (type manually) on the Scan screen
4. Tests: `⌘U` (13 unit tests + UI tests)

> The team's Firebase `GoogleService-Info.plist` is already included.

## 🧪 Tests

```
FoodInformationTests        — business rules for nutrition highlights
ProductStoreTests           — persistence, favorite toggling, recents dedupe/limit
OpenFoodFactsServiceTests   — API → domain model mapping, real JSON keys
SearchFoodsViewModelTests   — ViewModel with mocked service (protocol DI)
```

## 🔗 Project links

| Resource | Link |
|----------|------|
| 🎨 Final design (Figma) | [NutriScan App](https://www.figma.com/design/oEfbZ58pzE6HgwBap20CUH/NutriScan-App?node-id=0-1) |
| 🎨 Reference UI kit (Figma Community) | [Nutrition App UI](https://www.figma.com/design/95HYnqqA0MoqmwN7ObWfqo/Nutrition-App-UI--Community-) |
| 📋 Agile board (Trello) | [Sprint Board](https://trello.com/b/mc9AmW9S/trello-agile-sprint-board-template) |
| 📝 Project doc (Notion) | [Nutri-Scan](https://app.notion.com/p/Nutri-Scan-26391ed2afc280d5a6e1de19967de4f4) |
| 🌐 API | [Open Food Facts](https://world.openfoodfacts.org/) |
| 🍴 Original team repository | [elenadiniz/NutriScan](https://github.com/elenadiniz/NutriScan) |

## 👥 Team

Built during the bootcamp by [@elenadiniz](https://github.com/elenadiniz), [@raphaelavidal](https://github.com/raphaelavidal), [@MateusAndreatta](https://github.com/MateusAndreatta), [@abrahao-dev](https://github.com/abrahao-dev) and [@EderJrDev](https://github.com/EderJrDev).

**Completion work** (real nutrition data, favorites/recents persistence, manual barcode entry, working profile, tests and documentation): [@abrahao-dev](https://github.com/abrahao-dev).

## 📜 Commit convention

**Conventional Commits in Portuguese**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.

```
feat: adiciona tela de login com e-mail e senha
```
