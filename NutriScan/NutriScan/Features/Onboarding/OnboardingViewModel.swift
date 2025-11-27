//
//  OnboardingViewModel.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 30/09/25.
//

import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
    @Published var tapStartButton = false
    @Published var items = [OnboardingCarrouselItem(image: "onboarding1", title: "Coma saudável", subtitle: "Manter uma boa saúde deve ser o foco principal de todos."),
                            OnboardingCarrouselItem(image: "onboarding2", title: "Pesquise produtos", subtitle: "Pesquise e compare produtos antes de comprá-los."),
                            OnboardingCarrouselItem(image: "onboarding3", title: "Salve seus favoritos", subtitle: "Salve seus produtos favoritos depois de scanea-los")]
    
    init() {
        
    }
    
    func didTapStartButton() -> Bool {
        let tapButton = true
        tapStartButton = tapButton
        return tapButton
    }
    
}
