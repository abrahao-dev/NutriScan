//
//  OnboardingView.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            Text("Nutri Scan")
                .font(.semibold24)
                .foregroundStyle(.primaryColor1)
                .padding(.top, 37)
            
            OnboardingCarrouselView(items: viewModel.items)
            
            Button("Começar") {
                viewModel.didTapStartButton()
            }
            .font(.regular24)
            .padding(.top, 20)
            .padding(.bottom, 30)
            .buttonStyle(PrimaryButtonStyle())
            
            OnboardingFooter()
        }
    }
}

#Preview {
    OnboardingView()
}
