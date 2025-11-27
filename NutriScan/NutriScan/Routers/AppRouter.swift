//
//  AppRouter.swift
//  NutriScan
//
//  Created by Elena Diniz on 11/25/25.
//

import Combine

class AppRouter: ObservableObject {
    @Published var screen: Screen = .login
    @Published var selectedTab: Tabs = .home
    
    enum Screen {
        case login
        case register
        case home
    }
}
