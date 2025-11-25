//
//  RegisterView.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        Text("Cadastro")
                            .font(.semibold25)
                            .foregroundColor(Color.neutral1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                        
                        HStack(spacing: 15) {
                            Text("Nutri Scan")
                                .font(.semibold25)
                            
                            Image(systemName: "viewfinder")
                                .font(.system(size: 25, weight: .semibold))
                        }
                        .foregroundColor(Color.neutral1)
                        .padding(.bottom, 20)
                        
                        VStack(spacing: 16) {
                            
                            createTextField(label: "Nome *", text: $viewModel.nome)
                            createTextField(label: "E-mail *", text: $viewModel.email, keyboard: .emailAddress)
                            createTextField(label: "Confirme o E-mail *", text: $viewModel.confirmeEmail, keyboard: .emailAddress)
                            createSecureField(label: "Senha *", text: $viewModel.senha)
                            createSecureField(label: "Confirme sua senha *", text: $viewModel.confirmeSenha)
                            createTextField(label: "Telefone", text: $viewModel.telefone, keyboard: .phonePad)
                            
                        }
                        .padding(.horizontal, 30)
                        
                        Button {
                            Task {
                                if await viewModel.signUp() {
                                    withAnimation {
                                        router.screen = .home
                                    }
                                }
                            }
                        } label: {
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
                        
                        Spacer()
                        HStack(spacing: 4) {
                            Text("Já possui uma conta?")
                                .font(.regular17)
                                .foregroundColor(Color.neutral2)
                            
                            Button("Faça Login") {
                                withAnimation {
                                    router.screen = .login
                                }
                            }
                            .font(.semibold17)
                            .foregroundColor(Color.primary1)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding()
                }
            }
        }
    }
    
    // MARK: - COMPONENTES REUTILIZÁVEIS
    
    @ViewBuilder
    private func createTextField(label: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.regular17)
                .foregroundColor(Color.neutral2)
            
            TextField("", text: text)
                .font(.regular17)
                .padding(16)
                .background(Color.primary3)
                .border(Color.primary1)
                .cornerRadius(12)
                .keyboardType(keyboard)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
    }
    
    @ViewBuilder
    private func createSecureField(label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.regular17)
                .foregroundColor(Color.neutral2)
            
            SecureField("", text: text)
                .font(.regular17)
                .padding(16)
                .background(Color.primary3)
                .border(Color.primary1)
                .cornerRadius(12)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    RegisterView().environmentObject(AppRouter())
}
