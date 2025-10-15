//
//  IconCircleView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/14/25.
//

import SwiftUI

struct IconCircleView: View {
    var icon: IconType
    var backgroundColor: Color
    var foregroundColor: Color? = nil
    var size: CGFloat? = 40
    var padding: CGFloat = 20
    
    var body: some View {
        Group {
            switch icon {
            case .asset(let name):
                Image(name)
                    .resizable()
                    .scaledToFit()
            case .system(let name):
                Image(systemName: name)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(foregroundColor)
            }
        }
        .frame(width: size, height: size)
        .padding(padding)
        .background(backgroundColor)
        .clipShape(Circle())
    }
}

#Preview {
    IconCircleView(icon: .asset(name: "Broken Heart Icon"), backgroundColor: .iconBackground)
    IconCircleView(icon: .system(name: "checkmark"), backgroundColor: .primary1, foregroundColor: .icon1)
    IconCircleView(icon: .asset(name: "Fat Icon"), backgroundColor: .secondary2)
    IconCircleView(icon: .asset(name: "Muscle Arm Icon"), backgroundColor: .secondary3)
    IconCircleView(icon: .system(name: "suit.heart.fill"), backgroundColor: .iconBackground, foregroundColor: .icon2)
    IconCircleView(icon: .asset(name: "Intestine Icon"), backgroundColor: .secondary1)
    IconCircleView(icon: .asset(name: "Scan"), backgroundColor: .primary1)
    IconCircleView(icon: .system(name: "exclamationmark"), backgroundColor: .secondary2, foregroundColor: .alert2)
}
