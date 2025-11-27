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
                .environmentObject(AppRouter())
                .ignoresSafeArea()
                .navigationTitle("Perfil")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileRootView()
}
