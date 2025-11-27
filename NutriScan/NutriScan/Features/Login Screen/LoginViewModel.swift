//
//  LoginViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var senha = ""
    
    func loginUser() async -> Bool {
        do {
            let _ = try await AuthenticationManager.shared.loginUser(
                withEmail: email,
                password: senha
            )
            return true
        } catch {
            print("Erro ao logar:", error.localizedDescription)
            return false
        }
    }
}
