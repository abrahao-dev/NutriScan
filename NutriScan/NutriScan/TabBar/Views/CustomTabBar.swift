//
//  CustomTabBar.swift
//  NutriScan
//
//  Created by Elena Diniz on 9/25/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack {
            //MARK: - Home Button
            Button {
                selectedTab = .home
            } label: {
                if selectedTab == .home {
                    TabBarButton(buttonText: "Home", imageName: "house.fill")
                } else {
                    TabBarButton(buttonText: "Home", imageName: "house")
                }
            }
            .tint(Color.primary1)
            
            //MARK: - Search Button
            
            Button {
                selectedTab = .search
            } label: {
                GeometryReader { geo in
                    if selectedTab == .search {
                        VStack (alignment: .center, spacing: 8) {
                            Rectangle()
                                .frame(width: 100, height: 0.5)
                            Image("Lupa Fill Icon")
                                .font(.system(size: 20))
                                .frame(width: 24, height: 24)
                            Text("Pesquisa")
                                .font(.caption)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    TabBarButton(buttonText: "Pesquisa", imageName: "magnifyingglass")
                }
            }
            .tint(Color.primary1)
            
            //MARK: - Scan Button
            Button {
                selectedTab = .scan
            } label: {
                GeometryReader { geo in
                    VStack  {
                        ScanComponentView(width: 30, height: 30)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 70, height: 30)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            //MARK: - Favorites Button
            
            Button {
                selectedTab = .favorites
            } label: {
                if selectedTab == .favorites {
                    TabBarButton(buttonText: "Favoritos", imageName: "heart.fill")
                } else {
                    TabBarButton(buttonText: "Favoritos", imageName: "heart")
                }
            }
            .tint(Color.primary1)
            
            //MARK: - Profile Button
            Button {
                selectedTab = .profile
            } label: {
                if selectedTab == .profile {
                    TabBarButton(buttonText: "Perfil", imageName: "person.fill")
                } else {
                    TabBarButton(buttonText: "Perfil", imageName: "person")
                }
            }
            .tint(Color.primary1)
        }
        .frame(height: 68)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
