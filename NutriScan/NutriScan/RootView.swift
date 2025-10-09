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
        VStack {
            switch selectedTab {
            case .home:
                Text("Home")
                    .padding()
                Spacer()
//                HomeRootView()
            case .search:
                Text("Busca")
                    .padding()
                Spacer()
//                SearchRootView()
            case .scan:
                Text("Scaner")
                    .padding()
                Spacer()
//                ScanRootView()
            case .favorites:
                Text("Favoritos")
                    .padding()
                FavoriteRootView()
            case .profile:
                Text("Perfil")
                    .padding()
                Spacer()
//                ProfileRootView()
            }
            CustomTabBarView(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    RootView()
}
