//
//  OnboardingCarrouselView.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//

import SwiftUI

struct OnboardingCarrouselView: View {
    
    @State private var currentPage = 0
    let items = [OnboardingCarrouselItem(image: "onboarding1", title: "Coma saudável", subtitle: "Manter uma boa saúde deve ser o foco principal de todos."),
                 OnboardingCarrouselItem(image: "onboarding2", title: "Pesquise produtos", subtitle: "Pesquise e compare produtos antes de comprá-los."),
                 OnboardingCarrouselItem(image: "onboarding3", title: "Salve seus favoritos", subtitle: "Salve seus produtos favoritos depois de scanea-los")]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                OnboardingCarrouselItemView(item: item)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color.white.ignoresSafeArea())
        
        HStack(spacing: 8) {
            ForEach(items.indices, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.secondary1 : Color.secondary1.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut, value: currentPage)
            }
        }
    }
}

#Preview {
    OnboardingCarrouselView()
}
