//
//  AppRootView.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/25/25.
//

import SwiftUI

struct AppRootView: View {
    @StateObject var router = AppRouter()
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    var body: some View {
        if !hasSeenOnboarding {
            OnboardingView().environmentObject(router)
        } else {
            switch router.screen {
            case .login:
                LoginView().environmentObject(router)
            case .register:
                RegisterView().environmentObject(router)
            case .home:
                MainRootView().environmentObject(router)
            }
        }
    }
}

#Preview {
    AppRootView().environmentObject(AppRouter())
}
