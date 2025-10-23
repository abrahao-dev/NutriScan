//
//  RecentItemCellViewController.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 23/10/25.
//

import Foundation
import UIKit
import SwiftUI

class RecentItemCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RecentItemCell"
    
    private var hostingController: UIHostingController<NutriScoreView>?
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemGreen
        iv.backgroundColor = .clear
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 16
        
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(brandLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Imagem
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            
            // Nome
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Marca
            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            brandLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        brandLabel.text = product.brand
        
        productImageView.image = UIImage(systemName: product.imageName)
        
        if let hostingController = hostingController {
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
            self.hostingController = nil
        }
        
        let nutriScoreView = NutriScoreView(selectedScore: product.score)
        
        let controller = UIHostingController(rootView: nutriScoreView)
        self.hostingController = controller
        
        guard let hostedView = controller.view else { return }
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        hostedView.backgroundColor = .clear
        
        contentView.addSubview(hostedView)
        
        NSLayoutConstraint.activate([
            hostedView.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 12),
            hostedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hostedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hostedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
