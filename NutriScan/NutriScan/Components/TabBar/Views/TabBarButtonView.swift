//
//  TabBarButton.swift
//  NutriScan
//
//  Created by Elena Diniz on 9/29/25.
//

import SwiftUI

struct TabBarButtonView: View {
    
    var buttonText: String
    var imageName: String
    
    var body: some View {
        GeometryReader { geo in
                VStack (alignment: .center, spacing: 8) {
                    Rectangle()
                        .frame(width: 100, height: 0.5)
                    Image(systemName: imageName)
                        .font(.system(size: 20))
                        .frame(width: 24, height: 24)
                    Text(buttonText)
                        .font(.regular14)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color.white)
        }
    }
}

#Preview {
    TabBarButtonView(buttonText: "Home", imageName: "house.fill")
}
