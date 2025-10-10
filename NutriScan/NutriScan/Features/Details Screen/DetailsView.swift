//
//  DetailsView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/9/25.
//

import UIKit
import SwiftUI

class DetailsView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.init(name: "Signika", size: 18)
        title.textColor = UIColor(.neutralColor1)
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    
    private let brandLabel: UILabel = {
       let brand = UILabel()
        brand.font = UIFont.init(name: "Signika", size: 15)
        brand.textColor = UIColor(.neutralColor2)
        brand.textAlignment = .center
        return brand
    }()
    
    private let score: some View = NutriScoreView(selectedScore: .a)
    
    private var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(.primaryColor1)
        button.titleLabel?.text = "Salvar nos favoritos"
        button.titleLabel?.font = UIFont.init(name: "Signika", size: 15)
        button.titleLabel?.textColor = UIColor(.white)
        return button
    }()
    
    private var compareButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(.primaryColor3)
        button.titleLabel?.text = "Comparar produto"
        button.titleLabel?.font = UIFont.init(name: "Signika", size: 15)
        button.titleLabel?.textColor = UIColor(.white)
        return button
    }()

}
