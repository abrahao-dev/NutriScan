//
//  DetailsView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/9/25.
//

import UIKit
import SwiftUI

class DetailsScreen: UIView {

    var onCompareButtonTapped: (() -> Void)?
    var onFavoriteButtonTapped: (() -> Void)?
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView(image: .onboarding1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
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
    
    private let scoreImageView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(.primaryColor1)
        button.titleLabel?.font = UIFont(name: "Signika", size: 16)
        return button
    }()
    
    private let compareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(.primaryColor3)
        button.titleLabel?.font = UIFont(name: "Signika", size: 16)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favoriteButton, compareButton])
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setButtonConfiguration(button: favoriteButton, title: "Salvar nos Favoritos", image: UIImage(systemName: "heart"))
        setButtonConfiguration(button: compareButton, title: "Comparar Produto")
        
        compareButton.addTarget(self, action: #selector(handleCompareTap), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(handleFavoriteTap), for: .touchUpInside)
    }

    @objc private func handleCompareTap() {
        // 4. CHAME O CALLBACK
        onCompareButtonTapped?()
    }

    @objc private func handleFavoriteTap() {
        onFavoriteButtonTapped?()
    }

    /// Atualiza o visual do botão de favorito conforme o estado atual.
    func setFavorite(_ isFavorite: Bool) {
        setButtonConfiguration(
            button: favoriteButton,
            title: isFavorite ? "Remover dos Favoritos" : "Salvar nos Favoritos",
            image: UIImage(systemName: isFavorite ? "heart.fill" : "heart")
        )
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        backgroundColor = .white
        [productImageView, titleLabel, brandLabel, scoreImageView, infoStack, favoriteButton, compareButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        let imageSize: CGFloat = 180
        let margin: CGFloat = 100
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: imageSize),
            productImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: margin),
            productImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -margin),
            productImageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            brandLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            brandLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            scoreImageView.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 50),
            scoreImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            scoreImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreImageView.heightAnchor.constraint(equalToConstant: 80),
            
            infoStack.topAnchor.constraint(equalTo: scoreImageView.bottomAnchor, constant: 20),
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            favoriteButton.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 40),
            favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
            
            compareButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 20),
            compareButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            compareButton.leadingAnchor.constraint(equalTo: favoriteButton.leadingAnchor),
            compareButton.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor),
            compareButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

}

extension DetailsScreen {
    func configure(imageURL: URL?, productTitle: String, brand: String, score: NumberScore, infoItems: [InfoItem]) {
        loadImage(from: imageURL)
        titleLabel.text = productTitle
        brandLabel.text = brand
        makeScoreItem(score: score)
        
        infoStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        infoItems.forEach { item in
            let infoView = makeInfoItem(
                icon: item.icon,
                foregroundColor: item.foregroundColor,
                title: item.title,
                subtitle: item.subtitle,
                backgroundColor: item.backgroundColor
            )
            infoStack.addArrangedSubview(infoView)
        }
    }
}

private extension DetailsScreen {
    
    func makeSwiftUIScoreView(score: NumberScore) -> UIView {
        let swiftUIView = NutriScoreView(selectedScore: score)
        let controller = UIHostingController(rootView: swiftUIView)
        guard let scoreView = controller.view else {
            return UIView()
        }
        return scoreView
    }
    
    func makeScoreItem(score: NumberScore) -> UIView {
        let scoreView = makeSwiftUIScoreView(score: score)
        let view = scoreImageView
        view.addSubview(scoreView)
        
        return view
    }
    
    func makeSwiftUIIconView(icon: IconType, backgroundColor: Color, foregroundColor: Color? = nil) -> UIView {
        let swiftUIView = IconCircleView(icon: icon, backgroundColor: backgroundColor, foregroundColor: foregroundColor)
        let controller = UIHostingController(rootView: swiftUIView)
        guard let iconView = controller.view else {
            return UIView()
        }
        return iconView
    }
    
    func makeInfoItem(icon: IconType, foregroundColor: Color? = nil, title: String, subtitle: String, backgroundColor: Color) -> UIStackView {
        
        let iconView = makeSwiftUIIconView(icon: icon, backgroundColor: backgroundColor, foregroundColor: foregroundColor)
        let containerView = UIView()
        containerView.addSubview(iconView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 80),
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        let descriptionTitle = UILabel()
        descriptionTitle.text = title
        descriptionTitle.font = UIFont(name: "Signika", size: 16)
        descriptionTitle.textColor = UIColor(.neutral1)
        descriptionTitle.numberOfLines = 0
        descriptionTitle.textAlignment = .left
        
        let descriptionSubtitle = UILabel()
        descriptionSubtitle.text = subtitle
        descriptionSubtitle.font = UIFont(name: "Signika", size: 13)
        descriptionSubtitle.textColor = UIColor(.neutral2)
        descriptionSubtitle.numberOfLines = 0
        descriptionSubtitle.textAlignment = .left
        
        let textStack = UIStackView(arrangedSubviews: [descriptionTitle, descriptionSubtitle])
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = 0
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [containerView, textStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = false
        
        return stack
    }
    
    func loadImage(from url: URL?) {
        guard let url = url else {
            productImageView.image = UIImage(systemName: "photo")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self, let data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }.resume( )
    }
    
    func setButtonConfiguration(button: UIButton, title: String, image: UIImage? = nil,) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = image
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        config.imagePadding = 10
        config.cornerStyle = .medium
        
        button.configuration = config
    }
}
