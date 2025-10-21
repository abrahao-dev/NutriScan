//
//  OnboardingCarrouselItemView.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//

import SwiftUI

struct OnboardingCarrouselItemView: View {
    
    let item: OnboardingCarrouselItem
    
    var body: some View {
        VStack {
            Image(item.image)
                .frame(width: 282, height: 282)
            VStack {
                Text(item.title)
                    .font(.semibold25)
                    .padding(.top, 20)
                Text(item.subtitle)
                    .font(.regular17)
                    .opacity(0.45)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 50)

        }

    }
}

#Preview {
    OnboardingCarrouselItemView(item: .init(image: "onboarding1",
                                            title: "Titulo",
                                            subtitle: "Subtitulo"))
}
