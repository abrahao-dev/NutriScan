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
            Text("NutriScan")
                .padding()
            
            Spacer()
            
            CustomTabBarView(selectedTab: $selectedTab)
            
        }
    }
}

#Preview {
    RootView()
}
