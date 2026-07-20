# 📄 Documentação do Projeto — NutriScan

> Documentação exigida como pré-requisito de conclusão do Bootcamp Mobile iOS (MasterCode Academy).

---

## 1. 🎯 Objetivo do aplicativo

O **NutriScan** ajuda o usuário a entender rapidamente a qualidade nutricional dos alimentos que consome. Ao escanear o código de barras de um produto (ou buscá-lo por nome), o app exibe o **Nutri-Score** (escala A–E), destaques nutricionais em linguagem simples ("Bom para o coração", "Alto em proteínas") e permite comparar dois produtos lado a lado.

**Necessidade que atende:** rótulos nutricionais são difíceis de interpretar no momento da compra. O NutriScan traduz a tabela nutricional em informação visual e acionável, em segundos, no ponto de venda.

## 2. 👥 Público-alvo

- **Perfil:** pessoas que querem se alimentar melhor sem serem especialistas em nutrição — quem está de dieta, pais escolhendo produtos para os filhos, pessoas com restrições (gordura saturada, fibras).
- **Faixa etária:** 18–55 anos, habituados a apps de utilidade diária.
- **Tipo de uso:** consultas rápidas e frequentes no supermercado (sessões curtas, uma mão no celular), com revisão posterior dos favoritos em casa.

## 3. 🛠 Tecnologias e arquitetura

| Camada | Tecnologia |
|--------|-----------|
| UI | **UIKit (ViewCode)** + **SwiftUI** interoperando (`UIHostingController` / `UIViewControllerRepresentable`) |
| Arquitetura | **MVVM** — View, ViewModel (`ObservableObject`/Combine), Model |
| Autenticação | **Firebase Auth** (login, registro, redefinição de senha, perfil) |
| Persistência local | **UserDefaults + JSON (Codable)** — favoritos, recentes e telefone do perfil |
| Rede | **URLSession** com camada de serviço própria (`OpenFoodFactsService`) e DI via protocolo (`ProductServiceProtocol`) |
| Câmera/Barcode | **AVFoundation** (captura e detecção de código de barras) |
| Testes | **Swift Testing** (`#expect`), padrão Given/When/Then, mocks via protocolo |

**Justificativa das escolhas:**
- *UIKit ViewCode + SwiftUI:* o bootcamp cobre as duas stacks; o app usa UIKit nas telas montadas no início do curso (Home, Detalhes, Scan) e SwiftUI nas telas mais novas (Login, Busca, Favoritos, Comparação), refletindo o cenário real do mercado (codebases híbridas).
- *MVVM:* separa apresentação de lógica, viabiliza testes unitários dos ViewModels com mocks.
- *UserDefaults + JSON:* volume de dados pequeno (listas de produtos); não justifica Core Data/Realm. Firebase Firestore ficou fora do escopo para dados de produto (a fonte da verdade é a API pública).
- *Firebase Auth:* autenticação pronta, segura e gratuita para o volume do projeto.

## 4. 📋 Levantamento de requisitos

### ✅ Escopo (implementado)

1. Onboarding (primeira execução)
2. Cadastro e login com e-mail/senha (Firebase Auth)
3. Escanear código de barras com a câmera
4. Digitação manual do código de barras (fallback)
5. Busca de produtos por nome/marca com debounce
6. Tela de detalhes: foto, marca, Nutri-Score e destaques nutricionais **reais** (gordura, gordura saturada, proteínas, fibras por 100g)
7. Comparação de dois produtos lado a lado
8. Favoritos persistidos localmente (adicionar, remover, listar, swipe-to-delete)
9. Histórico "Salvos Recentemente" na Home (últimos 10 produtos vistos)
10. Edição de perfil (nome no Firebase, telefone local) e redefinição de senha
11. Estados vazios e tratamento de erro de rede com retry

### ❌ Não escopo

- Backend próprio (a API pública Open Food Facts é a fonte de dados)
- Cadastro/edição de produtos na base
- Recomendações personalizadas por IA
- Social (compartilhamento, comentários)
- Suporte offline completo do catálogo (apenas favoritos/recentes ficam offline)
- Monetização

## 5. ⚖️ Regras de negócio

1. **Nutri-Score:** vem do campo `nutrition_grades` da API; se ausente ou inválido, o produto recebe **E** (pior nota) por precaução.
2. **Destaques nutricionais** (por 100g, thresholds baseados nas referências do UK Food Standards Agency usadas pelo Nutri-Score):
   - Gordura < 3g → "Bom para o coração"; ≥ 17,5g → "Atenção ao consumo"
   - Gordura saturada ≥ 5g → "Alto em gordura saturada"
   - Proteínas ≥ 10g → "Construção de Ossos e Músculos"
   - Fibras ≥ 6g → "Auxilia no funcionamento do intestino"
   - Sem dados → aviso de "Informação nutricional limitada"
3. **Produto sem nome é descartado** da busca (registro inválido na base colaborativa).
4. **Recentes:** máximo 10, sem duplicatas (o produto revisitado volta ao topo).
5. **Identidade do produto:** código de barras; na ausência dele, nome+marca (case-insensitive).
6. **Favoritos:** por dispositivo (local), sem limite.
7. **Conta:** e-mail único; troca de senha sempre via link de redefinição por e-mail (nunca no app, evitando reautenticação insegura).

## 6. 🌐 Uso de API externa

**API:** [Open Food Facts](https://world.openfoodfacts.org/) — base colaborativa aberta de produtos alimentícios (gratuita, sem chave).

| Funcionalidade | Endpoint |
|----------------|----------|
| Busca por nome/marca | `GET /cgi/search.pl?search_terms={query}&json=1&page_size=20&cc=br` |
| Consulta por código de barras | `GET /api/v0/product/{barcode}.json` |

**Como o app consome e integra:**
- `OpenFoodFactsService` (URLSession) executa as requisições e decodifica o JSON com `Codable` (`OpenFoodFactsResponse` / `ProductAPI` / `NutrimentsAPI`).
- O serviço mapeia o modelo da API para o modelo interno `FoodInformation` (anti-corruption layer): valida nome obrigatório, normaliza Nutri-Score, carrega nutrientes por 100g e código de barras.
- ViewModels recebem o serviço por **injeção de dependência via protocolo** (`ProductServiceProtocol`), permitindo mock nos testes.
- Erros de rede viram mensagens amigáveis com botão "Tentar novamente"; no scanner, um overlay oferece re-escanear ou digitar o código.

## 7. 🔄 Fluxo de navegação e interações

```
Onboarding (1ª execução)
   └─► Login ◄─► Cadastro
         └─► TabBar principal
               ├─ 🏠 Home ── recentes ──► Detalhes (sheet)
               ├─ 🔍 Busca ── resultado ──► Detalhes (sheet)
               ├─ 📷 Scan ─┬─ barcode lido ──► Detalhes (push)
               │           └─ erro ──► digitar manualmente ──► Detalhes
               ├─ ❤️ Favoritos ── item ──► Detalhes (sheet)
               └─ 👤 Perfil ──► Editar perfil / Sair
                          Detalhes ──► Comparar ──► escolher 2º produto (scan ou busca)
```

**Comportamento esperado:**
- A TabBar customizada é o hub central; cada aba mantém seu próprio fluxo.
- Detalhes é a tela de convergência: qualquer caminho (scan, busca, favoritos, recentes) termina nela, e dela saem as ações de favoritar e comparar.
- Abrir Detalhes registra o produto nos Recentes automaticamente.
- Favoritar/desfavoritar atualiza Favoritos e Home em tempo real (Combine + NotificationCenter).

## 8. 🎨 Decisões de design

- **Cores:** verde como cor primária (saúde/alimentação natural); escala do Nutri-Score usa as cores oficiais (verde→vermelho) para leitura imediata da nota.
- **Tipografia:** família **Signika** nos títulos e conteúdos das telas de produto — legível e amigável; tamanhos hierárquicos (25 semibold para títulos, 17 para corpo, 13 para apoio).
- **Hierarquia visual:** imagem do produto → nome/marca → Nutri-Score → destaques → ações. A nota (informação mais importante) fica sempre acima da dobra.
- **Componentes reutilizáveis:** `NutriScoreView`, `IconCircleView`, `FoodInformationItemView`, `EmptyStateComponentView`, `InformativeBanner`, `CustomTabBarView`, `RecentItemCell` — mesmos componentes em UIKit e SwiftUI via hosting, garantindo consistência.
- **Padrões UX:** estados vazios ilustrados com instrução de próximo passo; erros sempre com ação de recuperação (retry/digitar manualmente); swipe-to-delete nos favoritos; feedback visual no botão de favorito (coração cheio/vazio).

---

*Design de referência no Figma: [NutriScan App](https://www.figma.com/design/oEfbZ58pzE6HgwBap20CUH/NutriScan-App)*
