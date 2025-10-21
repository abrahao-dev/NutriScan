//
//  LoginViewModel.swift
//  NutriScan
//
//  Created by Matheus Abrahao Martins Alvares on 21/10/25.
//

import Foundation
import Combine

// O ViewModel para a tela de Login.
// Como a tela é apenas UI, ele apenas guarda o estado.
class LoginViewModel: ObservableObject {

    // @Published avisa a View para atualizar quando esses valores mudarem
    @Published var email = ""
    @Published var senha = ""

    // Funções de lógica vazias por enquanto

    func fazerLogin() {
        // Sem lógica por enquanto
        print("Botão de Login clicado - (Lógica a implementar)")
    }

    func irParaCadastro() {
        // Sem lógica por enquanto
        print("Botão 'Cadastre-se' clicado - (Lógica a implementar)")
    }
}