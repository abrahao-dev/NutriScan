//
//  FavoriteRootView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/8/25.
//

import SwiftUI

struct FavoriteRootView: View {
    var body: some View {
        VStack {
            FavoriteViewControllerWrapper()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    FavoriteRootView()
}
