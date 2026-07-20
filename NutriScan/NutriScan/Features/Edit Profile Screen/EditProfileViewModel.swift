//
//  EditProfileViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine
import FirebaseAuth

// O ViewModel para a tela de Editar Perfil.
// Carrega os dados do usuário autenticado e persiste as alterações.
class EditProfileViewModel: ObservableObject {

    // @Published para cada campo do formulário
    @Published var nome = ""
    @Published var email = ""
    @Published var telefone = ""

    // Feedback para a View (alerta de sucesso/erro)
    @Published var feedbackMessage: String?
    @Published var isSaving = false

    private var telefoneKey: String {
        "nutriscan.telefone.\(Auth.auth().currentUser?.uid ?? "anon")"
    }

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
        // Telefone não existe no Firebase Auth; persistido localmente por usuário
        self.telefone = UserDefaults.standard.string(forKey: telefoneKey) ?? ""
    }

    /// Salva nome (Firebase Auth displayName) e telefone (local).
    func salvarAlteracoes() {
        guard let currentUser = Auth.auth().currentUser else {
            feedbackMessage = "Nenhum usuário autenticado."
            return
        }

        isSaving = true

        UserDefaults.standard.set(telefone, forKey: telefoneKey)

        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = nome
        changeRequest.commitChanges { [weak self] error in
            DispatchQueue.main.async {
                self?.isSaving = false
                if let error {
                    self?.feedbackMessage = "Erro ao salvar: \(error.localizedDescription)"
                } else {
                    self?.feedbackMessage = "Perfil atualizado com sucesso!"
                }
            }
        }
    }

    /// Envia e-mail de redefinição de senha (não exige reautenticação).
    func alterarSenha() {
        guard let email = Auth.auth().currentUser?.email else {
            feedbackMessage = "Nenhum e-mail associado à conta."
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            DispatchQueue.main.async {
                if let error {
                    self?.feedbackMessage = "Erro: \(error.localizedDescription)"
                } else {
                    self?.feedbackMessage = "Enviamos um link de redefinição de senha para \(email)."
                }
            }
        }
    }
}
