//
//  DetailsDescriptionView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/9/25.
//

import UIKit
import SwiftUI

class DetailsDescriptionView: UIView {
    
    private let mainView: UIView = {
        let mainView = UIView()
        mainView.clipsToBounds = true
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()

    private let descriptionTitleLabel: UILabel = {
        let descriptionTitle = UILabel()
        descriptionTitle.font = UIFont.init(name: "Signika", size: 14)
        descriptionTitle.textColor = UIColor(.neutral1)
        descriptionTitle.numberOfLines = 0
        descriptionTitle.textAlignment = .center
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTitle
    }()
    
    private let descriptionSubtitleLabel: UILabel = {
        let descriptionSubtitle = UILabel()
        descriptionSubtitle.font = UIFont.init(name: "Signika", size: 11)
        descriptionSubtitle.textColor = UIColor(.neutral2)
        descriptionSubtitle.numberOfLines = 0
        descriptionSubtitle.textAlignment = .center
        descriptionSubtitle.translatesAutoresizingMaskIntoConstraints = false
        return descriptionSubtitle
    }()
    
    private let mainStackView : UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .leading
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()
    
    private let textStackView : UIStackView = {
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.spacing = 10
        textStackView.distribution = .fillProportionally
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        return textStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
