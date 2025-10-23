//
//  RegisterViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine

// O ViewModel para a tela de Cadastro.
// Como a tela é apenas UI, ele apenas guarda o estado.
class RegisterViewModel: ObservableObject {

    // @Published para cada campo do formulário
    @Published var nome = ""
    @Published var email = ""
    @Published var confirmeEmail = ""
    @Published var senha = ""
    @Published var confirmeSenha = ""
    @Published var telefone = ""

    // Funções de lógica vazias

    func fazerCadastro() {
        // Sem lógica por enquanto
        print("Botão 'Cadastrar' clicado - (Lógica a implementar)")
    }

    func irParaLogin() {
        // Sem lógica por enquanto
        print("Botão 'Faça Login' clicado - (Lógica a implementar)")
    }
}