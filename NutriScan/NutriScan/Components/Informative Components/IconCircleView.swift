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
                Image(name.rawValue)
                    .resizable()
                    .scaledToFit()
            case .system(let name):
                Image(systemName: name.rawValue)
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
    IconCircleView(icon: .asset(name: .brokenHeart), backgroundColor: .iconBackground)
    IconCircleView(icon: .system(name: .checkmark), backgroundColor: .primary1, foregroundColor: .icon1)
    IconCircleView(icon: .asset(name: .fat), backgroundColor: .secondary2)
    IconCircleView(icon: .asset(name: .muscleArm), backgroundColor: .secondary3)
    IconCircleView(icon: .system(name: .heart), backgroundColor: .iconBackground, foregroundColor: .icon2)
    IconCircleView(icon: .asset(name: .intestine), backgroundColor: .secondary1)
    IconCircleView(icon: .asset(name: .scan), backgroundColor: .primary1)
    IconCircleView(icon: .system(name: .warning), backgroundColor: .secondary2, foregroundColor: .alert2)
}
