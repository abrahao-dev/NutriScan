//
//  RootView.swift
//  NutriScan
//
//  Created by Elena Diniz on 9/29/25.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .home
    
    var body: some View {
        
        NavigationView {
            VStack {
                switch selectedTab {
                case .home:
                    HomeRootView()
                        .navigationBarTitleDisplayMode(.inline)
                case .search:
                    SearchFoodView()
                case .scan:
                    // Conflito resolvido: Mantida a versão da 'develop'
                    ScanRootView()
                        .navigationBarTitleDisplayMode(.inline)
                case .favorites:
                    FavoriteRootView()
                        .navigationTitle(Text("Favoritos"))
                        .navigationBarTitleDisplayMode(.inline)
                case .profile:
                    ProfileRootView()
                        .navigationTitle("Perfil")
                        .navigationBarTitleDisplayMode(.inline)
                }
                CustomTabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    RootView()
}