//
//  CustomTabBarView.swift
//  NutriScan
//
//  Created by Elena Diniz on 9/25/25.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack {
            //MARK: - Home Button
            Button {
                selectedTab = .home
            } label: {
                if selectedTab == .home {
                    TabBarButtonView(buttonText: "Home", imageName: "house.fill")
                } else {
                    TabBarButtonView(buttonText: "Home", imageName: "house")
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
                                .font(.custom("Signika", size: 14))
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    TabBarButtonView(buttonText: "Pesquisa", imageName: "magnifyingglass")
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
                    TabBarButtonView(buttonText: "Favoritos", imageName: "heart.fill")
                } else {
                    TabBarButtonView(buttonText: "Favoritos", imageName: "heart")
                }
            }
            .tint(Color.primary1)
            
            //MARK: - Profile Button
            Button {
                selectedTab = .profile
            } label: {
                if selectedTab == .profile {
                    TabBarButtonView(buttonText: "Perfil", imageName: "person.fill")
                } else {
                    TabBarButtonView(buttonText: "Perfil", imageName: "person")
                }
            }
            .tint(Color.primary1)
        }
        .frame(height: 68)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
