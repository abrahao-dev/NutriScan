//
//  OnboardingFooter.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 30/09/25.
//

import SwiftUI

struct OnboardingFooter: View {
    
    var message1: AttributedString {
        var result = AttributedString("Já possui uma conta? ")
        result.font = .regular17
        result.foregroundColor = Color(red: 0.486, green: 0.486, blue: 0.486, opacity: 1)
        return result
    }

    var message2: AttributedString {
        var result = AttributedString("Faça ")
        result.font = .regular17
        result.foregroundColor = .primaryColor1
        return result
    }
    
    var message3: AttributedString {
        var result = AttributedString("Login")
        result.foregroundColor = .primaryColor1
        result.font = .semibold17
        return result
    }
    
    var body: some View {
        Text(message1 + message2 + message3)
    }
}

#Preview {
    OnboardingFooter()
}
