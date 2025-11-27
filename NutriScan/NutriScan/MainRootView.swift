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
            VStack {
                switch router.selectedTab {
                case .home:
                    HomeRootView()
                case .search:
                    SearchFoodView()
                case .scan:
                    ScanRootView()
                case .favorites:
                    FavoriteView()
                case .profile:
                    ProfileRootView()
                }
                CustomTabBarView(selectedTab: $router.selectedTab)
            }
        }
    }
}

#Preview {
    MainRootView().environmentObject(AppRouter())
}
