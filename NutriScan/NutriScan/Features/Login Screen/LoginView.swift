//
//  LoginView.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import SwiftUI

// View SwiftUI que desenha a tela
struct LoginView: View {

    // 1. Criamos e observamos o ViewModel
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        // ZStack para colocar a cor de fundo
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) { // VStack principal

                Spacer()

                // --- Logo ---
                HStack(spacing: 15) {
                    Text("Nutri Scan")
                        .font(.semibold25)

                    Image(systemName: "viewfinder")
                        // Ícones de sistema (SF Symbols) não usam fontes customizadas
                        // mas podemos igualar o tamanho e peso
                        .font(.system(size: 25, weight: .semibold))
                }
                .foregroundColor(Color.neutral1)
                .padding(.bottom, 30)

                // --- Campos de Texto ---
                VStack(spacing: 16) {
                    TextField("E-mail", text: $viewModel.email)
                        .font(.regular17)
                        .padding(16)
                        .background(Color.primary3)
                        .border(Color.primary1)
                        .cornerRadius(12)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)

                    SecureField("Senha", text: $viewModel.senha)
                        .font(.regular17)
                        .padding(16)
                        .background(Color.primary3)
                        .border(Color.primary1)
                        .cornerRadius(12)
                        .textContentType(.password)
                }
                .padding(.horizontal, 30)

                // --- Botão de Login ---
                Button(action: {
                    Task {
                        if let user = await viewModel.loginUser() {
                            print("Usuário logado com sucesso!")
                        }
                    }
                }) {
                    Text("Login")
                        .font(.semibold17)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.primary1)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)

                Spacer()

                // --- Link de Cadastro ---
                HStack(spacing: 4) {
                    Text("Ainda não tem uma conta?")
                        .font(.regular17)
                        .foregroundColor(Color.neutral2)

                    Button(action: {
                        viewModel.irParaCadastro() // Chama a função do ViewModel
                    }) {
                        Text("Cadastre-se")
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

// --- Preview ---
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
