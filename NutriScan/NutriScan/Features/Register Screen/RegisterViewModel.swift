//
//  RegisterViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine
import SwiftUI

class RegisterViewModel: ObservableObject {

    @Published var nome = ""
    @Published var email = ""
    @Published var confirmeEmail = ""
    @Published var senha = ""
    @Published var confirmeSenha = ""
    @Published var telefone = ""
    
    func signUp() async -> UserInfo? {
        guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        guard !confirmeEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        guard !senha.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        guard !confirmeSenha.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        
        do {
            let user = try await AuthenticationManager.shared.createUserAccount(
                withEmail: email,
                password: senha,
                name: nome
            )
            
            print("SUCESSO! UID: \(user.uid)")
            return user
        } catch {
            print("Erro no cadastro:", error.localizedDescription)
            return nil
        }
    }

    func fazerCadastro() {
        let user = AuthenticationManager.shared.getLoggedInUser()
        if user != nil {
            RootView().environmentObject(TabRouter())
        }
    }

    func irParaLogin() {
        // Sem lógica por enquanto
        print("Botão 'Faça Login' clicado - (Lógica a implementar)")
    }
}
