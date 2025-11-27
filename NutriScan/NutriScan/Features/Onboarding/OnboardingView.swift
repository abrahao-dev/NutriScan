//
//  OnboardingView.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject var router: AppRouter
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    var body: some View {
        VStack {
            Text("Nutri Scan")
                .font(.semibold24)
                .foregroundStyle(.primaryColor1)
                .padding(.top, 37)
            
            OnboardingCarrouselView(items: viewModel.items)
            
            Button("Começar") {
                if viewModel.didTapStartButton() {
                    hasSeenOnboarding = true
                    router.screen = .login
                }
            }
            .font(.regular24)
            .padding(.top, 20)
            .padding(.bottom, 30)
            .buttonStyle(PrimaryButtonStyle())
            
            Spacer()
            
            HStack {
                Text("Ainda não tem uma conta?")
                    .foregroundColor(.neutral2)
                    .font(Font.regular17)
                
                Button("Cadastre-se") {
                    withAnimation {
                        router.screen = .register
                    }
                }
                .foregroundColor(.primary1)
                .font(Font.regular17)
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    OnboardingView().environmentObject(AppRouter())
}
