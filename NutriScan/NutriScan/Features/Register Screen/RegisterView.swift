//
//  RegisterView.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import SwiftUI

// View SwiftUI que desenha a tela de Cadastro
struct RegisterView: View {

    // 1. Criamos e observamos o ViewModel
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        // ZStack para colocar a cor de fundo
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            // ScrollView para o formulário não quebrar com o teclado
            ScrollView {
                VStack(spacing: 20) { // VStack principal

                    // --- Título da Tela ---
                    Text("Cadastro")
                        .font(.semibold25)
                        .foregroundColor(Color.neutral1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20) // Espaço do topo

                    // --- Logo ---
                    HStack(spacing: 15) {
                        Text("Nutri Scan")
                            .font(.semibold25)

                        Image(systemName: "viewfinder")
                            .font(.system(size: 25, weight: .semibold))
                    }
                    .foregroundColor(Color.neutral1)
                    .padding(.bottom, 20) // Espaço abaixo do logo

                    // --- Campos de Texto ---
                    // Desta vez, os labels estão fora dos campos
                    VStack(spacing: 16) {

                        createTextField(label: "Nome: *", text: $viewModel.nome)
                        createTextField(label: "E-mail: *", text: $viewModel.email, keyboard: .emailAddress)
                        createTextField(label: "Confirme o E-mail: *", text: $viewModel.confirmeEmail, keyboard: .emailAddress)
                        createSecureField(label: "Crie sua senha: *", text: $viewModel.senha)
                        createSecureField(label: "Confirme sua senha: *", text: $viewModel.confirmeSenha)
                        createTextField(label: "Telefone:", text: $viewModel.telefone, keyboard: .phonePad)

                    }
                    .padding(.horizontal, 30)

                    // --- Botão de Cadastrar ---
                    Button(action: {
                        Task {
                            let user = await viewModel.signUp()
                        }
                    }) {
                        Text("Cadastrar")
                            .font(.semibold17)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primary1)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                    Spacer() // Empurra o link para baixo

                    // --- Link de Login ---
                    HStack(spacing: 4) {
                        Text("Já possui uma conta?")
                            .font(.regular17)
                            .foregroundColor(Color.neutral2)

                        Button(action: {
                            viewModel.irParaLogin() // Chama a função do ViewModel
                        }) {
                            Text("Faça Login")
                                .font(.semibold17)
                                .foregroundColor(Color.primary1)
                        }
                    }
                    .padding(.bottom, 20)

                }
                .padding()
            }
        }
    }

    // --- ViewBuilder para criar os campos de texto (evita repetição) ---

    @ViewBuilder
    private func createTextField(label: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.regular17)
                .foregroundColor(Color.neutral2) // Label cinza

            TextField("", text: text) // Placeholder vazio
                .font(.regular17)
                .padding(16)
                .background(Color.primary3)// Fundo verde claro
                .border(Color.primary1)
                .cornerRadius(12)
                .keyboardType(keyboard)
                .autocapitalization(.none)
                .autocorrectionDisabled()
        }
    }

    @ViewBuilder
    private func createSecureField(label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.regular17)
                .foregroundColor(Color.neutral2) // Label cinza

            SecureField("", text: text) // Placeholder vazio
                .font(.regular17)
                .padding(16)
                .background(Color.primary3) // Fundo verde claro
                .border(Color.primary1)
                .cornerRadius(12)
                .autocorrectionDisabled()
        }
    }
}

// --- Preview ---
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
