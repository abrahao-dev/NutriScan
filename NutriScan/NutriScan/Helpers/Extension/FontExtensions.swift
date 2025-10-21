//
//  FontExtensions.swift
//  NutriScan
//
//  Created by Mateus Andreatta on 30/09/25.
//

import SwiftUI

// Helpful doc https://developer.apple.com/documentation/applenewsformat/textstyle

extension Font {

    static var semibold25: Font {
        .custom("Signika", size: 25).weight(.semibold)// 600
    }
    
    static var semibold24: Font {
        .custom("Signika", size: 24).weight(.semibold)// 600
    }
    
    static var semibold17: Font {
        .custom("Signika", size: 17).weight(.semibold)// 600
    }
    
    static var regular17: Font {
        .custom("Signika", size: 17).weight(.regular)// 400
    }
    
    static var regular24: Font {
        .custom("Signika", size: 24).weight(.regular)// 400
    }
    
    static var regular14: Font {
        .custom("Signika", size: 14).weight(.regular) //400
    }
}
