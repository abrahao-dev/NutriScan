//
//  EditProfileViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine

// O ViewModel para a tela de Editar Perfil.
// Apenas guarda o estado dos campos.
class EditProfileViewModel: ObservableObject {

    // @Published para cada campo do formulário
    // Desta vez, iniciamos com dados de exemplo (como no design)
    @Published var nome = "Katherine Pierce"
    @Published var email = "katherine.pierce@icloud.com"
    @Published var telefone = "(11) 99899-9877"

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