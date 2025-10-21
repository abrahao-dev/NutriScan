//
//  PrimaryButtonStyle.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 27/09/25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 19)
            .frame(minWidth: 200)
            .background(.primaryColor1)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
