//
//  ProfileRootView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/16/25.
//

import SwiftUI

struct ProfileRootView: View {
    var body: some View {
        VStack {
            ProfileViewControllerWrapper()
                .environmentObject(TabRouter())
                .ignoresSafeArea()
                .navigationTitle("Perfil")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileRootView()
}
