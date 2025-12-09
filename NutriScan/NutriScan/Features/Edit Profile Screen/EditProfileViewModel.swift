//
//  EditProfileViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine
import FirebaseAuth

// O ViewModel para a tela de Editar Perfil.
// Carrega os dados do usuário autenticado
class EditProfileViewModel: ObservableObject {

    // @Published para cada campo do formulário
    @Published var nome = ""
    @Published var email = ""
    @Published var telefone = ""

    init() {
        loadUserData()
    }

    private func loadUserData() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }

        // Carrega os dados do usuário autenticado
        if let displayName = currentUser.displayName, !displayName.isEmpty {
            self.nome = displayName
        } else if let userEmail = currentUser.email {
            // Se não houver displayName, usa o email como fallback
            self.nome = userEmail
        } else {
            self.nome = "Usuário"
        }

        self.email = currentUser.email ?? ""
        // Telefone não está disponível no Firebase Auth, mantém vazio
        self.telefone = ""
    }

    // Funções de lógica vazias

    func salvarAlteracoes() {
        // Sem lógica por enquanto
        print("Botão 'Salvar' clicado - (Lógica a implementar)")
    }

    func alterarSenha() {
        // Sem lógica por enquanto
        print("Botão 'Alterar senha' clicado - (Lógica a implementar)")
    }
}