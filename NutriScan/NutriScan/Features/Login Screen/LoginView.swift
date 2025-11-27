//
//  LoginView.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer()
                
                HStack(spacing: 15) {
                    Text("Nutri Scan")
                        .font(.semibold25)
                    
                    Image(systemName: "viewfinder")
                        .font(.system(size: 25, weight: .semibold))
                }
                .foregroundColor(.neutral1)
                .padding(.bottom, 30)
                
                VStack(spacing: 16) {
                    TextField("E-mail", text: $viewModel.email)
                        .padding(16)
                        .background(Color.primary3)
                        .border(Color.primary1)
                        .cornerRadius(12)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Senha", text: $viewModel.senha)
                        .padding(16)
                        .background(Color.primary3)
                        .border(Color.primary1)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 30)
                
                Button {
                    Task {
                        if await viewModel.loginUser() {
                            withAnimation {
                                router.screen = .home
                            }
                        }
                    }
                } label: {
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
                HStack {
                    Text("Ainda não tem uma conta?")
                        .foregroundColor(.neutral2)
                    
                    Button("Cadastre-se") {
                        withAnimation {
                            router.screen = .register
                        }
                    }
                    .foregroundColor(.primary1)
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppRouter())
    }
}
