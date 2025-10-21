//
//  DetailsViewController.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/9/25.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = DetailsView()
    
    
    private var productTitle: String
    private var brand: String
    private var imageURL: URL?
    private var score: NumberScore
    private var infoItems: [InfoItem]
    
    init(title: String, brand: String, imageURL: URL?, score: NumberScore, infoItem: [InfoItem]) {
        self.productTitle = title
        self.brand = brand
        self.imageURL = imageURL
        self.score = score
        self.infoItems = infoItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configure()
    }
}

extension DetailsViewController {
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }
    
    private func configure() {
        contentView.configure(
            imageURL: imageURL,
            productTitle: productTitle,
            brand: brand,
            score: score,
            infoItems: infoItems
        )
    }
}

struct DetailsViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DetailsViewController

    func makeUIViewController(context: Context) -> DetailsViewController {
        return DetailsViewController(title: "Biscoite Recheado", brand: "Trakinas", imageURL: URL(string: "https://placehold.co/60")!, score: .scoreE, infoItem: [
            .init(icon: .system(name: .heart), foregroundColor: .icon2,  title: "Bom para o coração", subtitle: "Baixo em gordura: 2,80g", backgroundColor: .iconBackground),
            .init(icon: .asset(name: .muscleArm), foregroundColor: nil, title: "Construção de Ossos e Músculos", subtitle: "Alto em proteínas: 14g", backgroundColor: .secondary3),
            .init(icon: .asset(name: .intestine), foregroundColor: nil, title: "Auxilia no funcionamento do intestino", subtitle: "Rico em fibras: 10g", backgroundColor: .secondary1),
            .init(icon: .system(name: .checkmark), foregroundColor: .icon1, title: "Lactose", subtitle: "Zero em lactose", backgroundColor: .primary1)
        ])
    }

    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
        
    }
}
