//
//  ProfileRootView.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 22/10/25.
//

import SwiftUI

struct HomeRootView: View {
    var body: some View {
        VStack {
            HomeViewControllerWrapper()
                .ignoresSafeArea()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeRootView()
}
