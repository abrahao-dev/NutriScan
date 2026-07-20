//
//  EditProfileView.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import SwiftUI

// View SwiftUI que desenha a tela de Editar Perfil
struct EditProfileView: View {

    // 1. Criamos e observamos o ViewModel
    @StateObject private var viewModel = EditProfileViewModel()

    var body: some View {
        // ZStack para colocar a cor de fundo
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) { // VStack principal

                // --- Título da Tela ---
                Text("Editar perfil")
                    .font(.semibold25)
                    .foregroundColor(Color.neutral1)
                    .frame(maxWidth: .infinity, alignment: .center) // Título centralizado
                    .padding(.top, 20)

                Spacer() // Empurra o conteúdo para o centro

                // --- Campos de Texto ---
                VStack(spacing: 16) {

                    createTextField(label: "Nome:", text: $viewModel.nome)
                    createTextField(label: "E-mail:", text: $viewModel.email, keyboard: .emailAddress)
                    createTextField(label: "Telefone:", text: $viewModel.telefone, keyboard: .phonePad)

                }
                .padding(.horizontal, 30)

                Spacer() // Empurra os botões para baixo

                // --- Botões ---
                VStack(spacing: 16) {
                    Button(action: {
                        viewModel.alterarSenha() // Chama a função do ViewModel
                    }) {
                        Text("Alterar senha")
                            .font(.semibold17)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primary1)
                            .cornerRadius(12)
                    }

                    Button(action: {
                        viewModel.salvarAlteracoes() // Chama a função do ViewModel
                    }) {
                        Text("Salvar")
                            .font(.semibold17)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primary1)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40) // Espaço da parte de baixo
            }
            .padding()
        }
        .alert(
            viewModel.feedbackMessage ?? "",
            isPresented: Binding(
                get: { viewModel.feedbackMessage != nil },
                set: { if !$0 { viewModel.feedbackMessage = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        }
    }

    // --- ViewBuilder para criar os campos de texto (reutilizado) ---
    // (Exatamente o mesmo da tela de Cadastro)
    @ViewBuilder
    private func createTextField(label: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.regular17)
                .foregroundColor(Color.neutral2) // Label cinza

            TextField("", text: text) // Placeholder vazio
                .font(.regular17)
                .padding(16)
                .background(Color.primary3) // Fundo verde claro
                .cornerRadius(12)
                .keyboardType(keyboard)
                .autocapitalization(.none)
        }
    }
}

// --- Preview ---
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}