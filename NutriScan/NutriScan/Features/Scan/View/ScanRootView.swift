//
//  ProfileRootView.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 22/10/25.
//

import SwiftUI

struct ScanRootView: View {
    var body: some View {
        VStack {
            ScanViewControllerWrapper()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ScanRootView()
}
