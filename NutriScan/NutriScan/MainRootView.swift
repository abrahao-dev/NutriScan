//
//  RootView.swift
//  NutriScan
//
//  Created by Elena Diniz on 9/29/25.
//

import SwiftUI

struct MainRootView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                switch router.selectedTab {
                case .home:
                    HomeRootView()
                case .search:
                    SearchFoodView()
                        .ignoresSafeArea(edges: .bottom)
                case .scan:
                    ScanRootView()
                case .favorites:
                    FavoriteView()
                case .profile:
                    ProfileRootView()
                }
                CustomTabBarView(selectedTab: $router.selectedTab)
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MainRootView().environmentObject(AppRouter())
}
