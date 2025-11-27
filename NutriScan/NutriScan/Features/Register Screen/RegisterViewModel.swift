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
    
    func signUp() async -> Bool {
        
        guard !nome.isEmpty,
              !email.isEmpty,
              !confirmeEmail.isEmpty,
              !senha.isEmpty,
              !confirmeSenha.isEmpty
        else {
            print("Erro: campos vazios.")
            return false
        }
        
        do {
            let user = try await AuthenticationManager.shared.createUserAccount(
                withEmail: email,
                password: senha,
                name: nome
            )
            print("Usuário cadastrado:", user.uid)
            return true
            
        } catch {
            print("Erro no cadastro: \(error)")
            return false
        }
    }
}
